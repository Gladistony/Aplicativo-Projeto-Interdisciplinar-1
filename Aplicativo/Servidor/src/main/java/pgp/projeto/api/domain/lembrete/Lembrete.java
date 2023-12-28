package pgp.projeto.api.domain.lembrete;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import pgp.projeto.api.domain.usuario.UserAccount;

import java.time.LocalDate;
import java.time.LocalTime;

@Table(name = "lembretes")
@Entity(name = "Lembrete")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id")
public class Lembrete {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

   
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "conta_id")
    private UserAccount usuario;

    private LocalDate dataInicio;
    private String nomeMedicamento;
    private LocalTime horario;
    private Float dosagem;
    private int intervaloHora;
 

}
