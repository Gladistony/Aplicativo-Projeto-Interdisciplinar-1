package pgp.projeto.api.domain.lembrete;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.time.LocalTime;

public record DadosRegistroLembrete(
        
        @NotNull Long idUsuario,
        @NotNull @Future LocalDate dataInicio,
        @NotNull String nomeMedicamento,
        @NotNull LocalTime horario,
        @NotNull Float dosagem,
        @NotNull int intervaloHora
) {
}
