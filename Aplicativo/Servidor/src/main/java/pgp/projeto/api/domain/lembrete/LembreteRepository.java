package pgp.projeto.api.domain.lembrete;

import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;

public interface LembreteRepository extends JpaRepository<Lembrete, Long> {

  
}
