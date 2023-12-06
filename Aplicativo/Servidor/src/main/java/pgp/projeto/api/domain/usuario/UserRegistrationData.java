package pgp.projeto.api.domain.usuario;


import java.time.LocalDate;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record UserRegistrationData(

    @NotBlank
    String nome,

    @NotBlank
    @Email
    String email,

    @NotBlank
    String senha,

    LocalDate dataNascimento,

    byte[] perfilFoto
    
       ) {

}
