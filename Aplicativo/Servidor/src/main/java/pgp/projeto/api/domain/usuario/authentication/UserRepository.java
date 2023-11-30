package pgp.projeto.api.domain.usuario.authentication;

import org.springframework.data.jpa.repository.JpaRepository;

import pgp.projeto.api.domain.usuario.UserAccount;

public interface UserRepository extends JpaRepository<UserAccount, Long> {

    
    UserAccount findByLogin(String login);

    
}
