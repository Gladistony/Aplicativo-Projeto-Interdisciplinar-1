package pgp.projeto.api.domain.usuario;

import java.time.LocalDate;

public record UserDetailsData(Long id, String nome, String email, LocalDate dataNascimento) {
    public UserDetailsData(UserAccount user) {
        this(user.getId(), user.getNome(), user.getLogin(), user.getDataNascimento());
    }
}
