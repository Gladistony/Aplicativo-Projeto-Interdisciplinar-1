package pgp.projeto.api.domain.lembrete;

import jakarta.validation.constraints.NotNull;

public record DadosCancelamentoLembrete(
        @NotNull
        Long idLembrete
       ) {
}
