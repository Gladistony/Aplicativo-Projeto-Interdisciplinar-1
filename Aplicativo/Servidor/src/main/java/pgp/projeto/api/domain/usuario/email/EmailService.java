package pgp.projeto.api.domain.usuario.email;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import pgp.projeto.api.domain.usuario.UserAccount;

@Service
public class EmailService {

    private final JavaMailSender emailSender;

    public EmailService(JavaMailSender emailSender) {
        this.emailSender = emailSender;
    }

    public void sendWelcomeEmail(UserAccount user) {
        
        SimpleMailMessage message = new SimpleMailMessage(); 
        message.setTo(user.getLogin());
        message.setSubject("Bem-vindo ao nosso serviço!");
        message.setText("Olá " + user.getNome() + ",\n\nObrigado por se cadastrar em nosso serviço. Estamos felizes em tê-lo conosco.\n\nAtenciosamente,\nEquipe do Serviço");
        emailSender.send(message);
                    
    }

}
