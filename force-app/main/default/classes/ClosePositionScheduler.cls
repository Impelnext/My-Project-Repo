global class ClosePositionScheduler implements Schedulable {
    global void execute(SchedulableContext sc){
        List<Positions__c> positionToClose = [SELECT 
                                                   Id,
                                                   Close_Position__c 
                                             FROM Positions__c 
                                             WHERE Close_Position__c = false 
                                             AND CreatedDate = LAST_N_DAYS:30];
        
        for(Positions__c position:positionToClose){
            position.Close_Position__c =true;
        }
        update positionToClose;
    }

}