package pgp.projeto.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import pgp.projeto.api.domain.usuario.UserAccount;
import pgp.projeto.api.domain.usuario.UserDetailsData;
import pgp.projeto.api.domain.usuario.UserRegistrationData;
import pgp.projeto.api.domain.usuario.UserUpdateData;
import pgp.projeto.api.domain.usuario.authentication.UserRepository;






@RestController
@RequestMapping("/cadastro")
public class UserAccountController {
    
    @Autowired
    private UserRepository repository;
    @PostMapping
    @Transactional
    public ResponseEntity cadastrar(@RequestBody @Valid UserRegistrationData dados, UriComponentsBuilder uriBuilder) {
       var usuario = new UserAccount(dados);
       repository.save(usuario);
       var uri = uriBuilder.path("/usuarios/{id}").buildAndExpand(usuario.getId()).toUri();
   
       return ResponseEntity.created(uri).body(new UserDetailsData(usuario));
    }

    @PutMapping
    @Transactional
    public ResponseEntity atualizar(@RequestBody @Valid UserUpdateData dados, Authentication authentication){
        var usuario = repository.getReferenceById(dados.id());
        usuario.atualizarInformacoes(dados);
        
        // Obtém os detalhes do usuário autenticado a partir da autenticação
        UserAccount usuarioAutenticado = (UserAccount) authentication.getPrincipal();
       
         // Verifica se o ID passado na URL é igual ao ID do usuário autenticado
        
        if (!usuarioAutenticado.getId().equals(dados.id())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
            return ResponseEntity.ok(new UserDetailsData(usuario));

    }
    
    @DeleteMapping("/{id}")
    @Transactional
    public ResponseEntity remover(@PathVariable Long id, Authentication authentication) {
        
        // Obtém os detalhes do usuário autenticado a partir da autenticação
        UserAccount usuarioAutenticado = (UserAccount) authentication.getPrincipal();

        // Verifica se o ID passado na URL é igual ao ID do usuário autenticado
        if (!usuarioAutenticado.getId().equals(id)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        var usuario = repository.getReferenceById(id);
        repository.delete(usuario);
        return ResponseEntity.noContent().build();
    }


    @GetMapping("/{id}")
    public ResponseEntity detalhar(@PathVariable Long id,  Authentication authentication){
        var usuario = repository.getReferenceById(id);
         // Obtém os detalhes do usuário autenticado a partir da autenticação
         UserAccount usuarioAutenticado = (UserAccount) authentication.getPrincipal();

         // Verifica se o ID passado na URL é igual ao ID do usuário autenticado
         if (!usuarioAutenticado.getId().equals(id)) {
             return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
         }
         
         return ResponseEntity.ok(new UserDetailsData(usuario));
    }
}
