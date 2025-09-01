
import java.util.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;


public class SendSimpleEmail{

    final String senderEmailId= "maksudularafin@gmail.com";
    final String senderPassword = "pspd anmk aqtx iukv";
    final String emailSMTPServer = "smtp.gmail.com";

    public SendSimpleEmail(List<String> recipientEmails, String subject, String messages){

        Properties props = new Properties();
        props.put("mail.smtp.auth","true");
        props.put("mail.smtp.ssl.enable","true");
        props.put("mail.smtp.host",emailSMTPServer);
        props.put("mail.smtp.port","465");


        try{
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmailId,senderPassword);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmailId));
            String recipients= String.join(",",recipientEmails);
            message.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(recipients));
            message.setSubject(subject);
            message.setText(messages);
            
            Transport.send(message);
            System.out.println("Email is Successfull.\n");
        }catch(Exception e){
            e.printStackTrace();
            System.err.println("Error sending the Email" + e.getMessage());
        }
    }




    public static void main(String []args){

        // List<String> recipients = Arrays.asList(
        //     "ninoboy147147@gmail.com",
        //     "ninoboy243024@gmail.com",
        //     "rocksterdowan@gmail.com"
        // );

        // new SendSimpleEmail(recipients, "Final Test", "Just Do It.\n");

        Scanner sc = new Scanner(System.in);

        String mailName = sc.nextLine();
        List<String> recipients = Arrays.asList(mailName.split("\\s*,\\s*"));

        String subject = sc.nextLine();

        String messeges = sc.nextLine();

        new SendSimpleEmail(recipients, subject, messeges);
        
        sc.close();
    }
}