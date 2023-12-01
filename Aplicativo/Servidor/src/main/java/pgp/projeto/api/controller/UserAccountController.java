package pgp.projeto.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity atualizar(@RequestBody @Valid UserUpdateData dados){
        var usuario = repository.getReferenceById(dados.id());
        usuario.atualizarInformacoes(dados);

        return ResponseEntity.ok(new UserDetailsData(usuario));

    }
    
    @DeleteMapping("/{id}")
    @Transactional
    public ResponseEntity remover(@PathVariable Long id) {
        var usuario = repository.getReferenceById(id);
        usuario.excluir();
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity detalhar(@PathVariable Long id){
        var usuario = repository.getReferenceById(id);
        return ResponseEntity.ok(new UserDetailsData(usuario));
    }
}
