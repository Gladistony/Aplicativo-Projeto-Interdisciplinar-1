package pgp.projeto.api.domain.usuario;


import java.time.LocalDate;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;


public record UserRegistrationData(

    @NotBlank
    String nome,

    @NotBlank
    @Email
    String email,

    @NotBlank
    String senha,

    @NotNull
    LocalDate dataNascimento

       ) {

}
