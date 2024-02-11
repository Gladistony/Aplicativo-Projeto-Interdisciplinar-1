package pgp.projeto.api.domain.lembrete;


import pgp.projeto.api.domain.usuario.authentication.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AgendaDeLembretes {

    @Autowired
    private LembreteRepository lembreteRepository;

    @Autowired
    private UserRepository userRepository;


    // @Autowired
    // private List<ValidadorAgendamentoDeConsulta> validadores;

    // @Autowired
    // private List<ValidadorCancelamentoDeConsulta> validadoresCancelamento;

    public DadosDetalhamentoLembrete agendar(DadosRegistroLembrete dados) {
        // if (!pacienteRepository.existsById(dados.idPaciente())) {
        //     throw new ValidacaoException("Id do paciente informado não existe!");
        // }

        // if (dados.idMedico() != null && !medicoRepository.existsById(dados.idMedico())) {
        //     throw new ValidacaoException("Id do médico informado não existe!");
        // }

        // validadores.forEach(v -> v.validar(dados));

        // var paciente = pacienteRepository.getReferenceById(dados.idPaciente());
        // var medico = escolherMedico(dados);
        // if (medico == null) {
        //     throw new ValidacaoException("Não existe médico disponível nessa data!");
        // }

        var lembrete = new Lembrete(
            null,
            userRepository.getReferenceById(dados.idUsuario()),
            dados.dataInicio(),
            dados.nomeMedicamento(),
            dados.horario(),
            dados.dosagem(),
            dados.intervaloHora()
        );
        lembreteRepository.save(lembrete);

        return new DadosDetalhamentoLembrete(lembrete);
    }

    public void excluir(DadosCancelamentoLembrete dados) {
        // if (!consultaRepository.existsById(dados.idConsulta())) {
        //     throw new ValidacaoException("Id da consulta informado não existe!");
        // }

        // validadoresCancelamento.forEach(v -> v.validar(dados));
        
        var lembrete = lembreteRepository.getReferenceById(dados.idLembrete());
        lembreteRepository.delete(lembrete);

        
    }


    // private Medico escolherMedico(DadosAgendamentoConsulta dados) {
    //     if (dados.idMedico() != null) {
    //         return medicoRepository.getReferenceById(dados.idMedico());
    //     }

    //     if (dados.especialidade() == null) {
    //         throw new ValidacaoException("Especialidade é obrigatória quando médico não for escolhido!");
    //     }

    //     return medicoRepository.escolherMedicoAleatorioLivreNaData(dados.especialidade(), dados.data());
    // }

}
