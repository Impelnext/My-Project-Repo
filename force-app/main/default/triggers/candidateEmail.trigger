trigger candidateEmail on Candidate__c (after insert,after update) {
    //List<Candidate__c> emailList  = new List<Candidate__c>();
     List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
    for(Candidate__c candidate :Trigger.new){
        if(Trigger.isInsert ||(Trigger.isUpdate && Trigger.oldMap.get(candidate.id).Email__c == null && candidate.Email__c!=null)){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{ candidate.Email__c });
            email.setSubject('Account Has Been Created');
            email.setPlainTextBody('Dear ' + candidate.First_Name__c + ',\n\n' +
                                   'We wanted to inform you that your email address has been updated to ' + candidate.Email__c + '.\n' +
                                   'If you have any questions, please feel free to contact us.\n\n' +
                                   'Best regards,\n' +
                                   'Leala');
            
            emailList.add(email);
        }
    }
 
    if (!emailList.isEmpty()) {
        Messaging.sendEmail(emailList);
    }

}