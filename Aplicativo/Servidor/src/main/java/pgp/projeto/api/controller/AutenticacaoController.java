package pgp.projeto.api.controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import pgp.projeto.api.domain.usuario.UserAccount;
import pgp.projeto.api.domain.usuario.UserUpdateData;
import pgp.projeto.api.domain.usuario.authentication.AuthenticationData;
import pgp.projeto.api.domain.usuario.authentication.UserRepository;
import pgp.projeto.api.domain.usuario.email.EmailService;
import pgp.projeto.api.infra.security.DadosTokenJWT;
import pgp.projeto.api.infra.security.TokenService;

@RestController
@RequestMapping("/login")
public class AutenticacaoController {
    
    @Autowired
    private AuthenticationManager manager;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private EmailService emailService;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository repository;

    @PostMapping
    public ResponseEntity efeturarLogin(@RequestBody @Valid AuthenticationData
    dados){
        var authenticationToken = new UsernamePasswordAuthenticationToken(dados.login(), dados.senha());
        var authentication = manager.authenticate(authenticationToken);

        var tokenJWT = tokenService.gerarToken((UserAccount) authentication.getPrincipal());
        var contaId =  ((UserAccount) authentication.getPrincipal()).getId();
        return ResponseEntity.ok(new DadosTokenJWT(tokenJWT, contaId));
    }

    @PostMapping("/recuperar-senha")
    public ResponseEntity recuperarSenha(@RequestBody @Valid UserUpdateData dados, Authentication authentication) {
        
        UserAccount usuarioAutenticado = (UserAccount) authentication.getPrincipal();
        
        if (!usuarioAutenticado.getId().equals(dados.id())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }


        UserAccount user = repository.getReferenceById(dados.id());
        if (user == null) {
            return ResponseEntity.badRequest().body("Usuário não encontrado");
        }

        // Gere uma nova senha aleatória
        String novaSenha = generateRandomPassword();

        emailService.sendResetPasswordEmail(user, novaSenha);
        user.setSenha(novaSenha, passwordEncoder);
        repository.save(user);
        
        
        return ResponseEntity.ok().build();
    }

    private String generateRandomPassword() {
        // Este é um exemplo simples de como gerar uma senha aleatória
        // Você pode querer usar um método mais seguro e complexo
        Random random = new Random();
        return String.valueOf(random.nextInt(1000000));
    }
}
    

