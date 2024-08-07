public class EmailManager 
{
    public static void sendMail(String address, String subject, String body) {
        Messaging.SingleEmailMessage mail =new messaging.SingleEmailMessage();
        String[] toaddresses =new String[] {address};
        mail.setToAddresses(toaddresses);    
        mail.setsubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail});
    }

}