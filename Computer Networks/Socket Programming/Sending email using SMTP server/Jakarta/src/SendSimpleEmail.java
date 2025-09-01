import java.util.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class SendSimpleEmail {
    final String senderEmailId = "maksudularafin@gmail.com";
    final String senderPassword = "pspd anmk aqtx iukv"; // App password
    final String emailSMTPserver = "smtp.gmail.com";

    public SendSimpleEmail(String receiverEmail,
                           String subject, String messageText) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true"); // TLS enabled
        props.put("mail.smtp.host", emailSMTPserver);
        props.put("mail.smtp.port", "465");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmailId, senderPassword);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmailId));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiverEmail));
            message.setSubject(subject);
            message.setText(messageText);

            Transport.send(message);
            System.out.println("✅ Email sent successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("❌ Error in sending email: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        new SendSimpleEmail("ninoboy147147@gmail.com",
                "Code Testing", "Successful (_-_) with Jakarta Mail!");
    }
}
