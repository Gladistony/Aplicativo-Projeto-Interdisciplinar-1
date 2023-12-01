package pgp.projeto.api.domain.usuario;

import java.time.LocalDate;

import jakarta.validation.constraints.NotNull;



public record UserUpdateData(@NotNull Long id, String nome, LocalDate dataNascimento) {
    
}
