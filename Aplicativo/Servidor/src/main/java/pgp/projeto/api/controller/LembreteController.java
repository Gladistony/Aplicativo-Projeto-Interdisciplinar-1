package pgp.projeto.api.controller;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;
import pgp.projeto.api.domain.lembrete.AgendaDeLembretes;
import pgp.projeto.api.domain.lembrete.DadosCancelamentoLembrete;
import pgp.projeto.api.domain.lembrete.DadosRegistroLembrete;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("lembretes")
@SecurityRequirement(name = "bearer-key")
public class LembreteController {

    @Autowired
    private AgendaDeLembretes lembrete;

    @PostMapping
    @Transactional
    public ResponseEntity criar(@RequestBody @Valid DadosRegistroLembrete dados) {
        var dto = lembrete.agendar(dados);
        return ResponseEntity.ok(dto);
    }

    @DeleteMapping
    @Transactional
    public ResponseEntity excluir(@RequestBody @Valid DadosCancelamentoLembrete dados) {
        lembrete.excluir(dados);
        return ResponseEntity.noContent().build();
    }

}
