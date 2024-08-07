trigger UpdateReviewProvided on Review__c (after insert, after update) {
    List<Id> jobApplicationIds = new List<Id>();
    
    for (Review__c review : Trigger.new) {
        jobApplicationIds.add(review.Job_Application__c);
    }
    
    Map<Id, Job_Application__c> jobApplicationsMap = new Map<Id, Job_Application__c>(
        [SELECT Id, Review_Provided__c, (SELECT Id, Rating__c FROM Review__r) 
         FROM Job_Application__c WHERE Id IN :jobApplicationIds]
    );
    
    List<Job_Application__c> jobApplicationsToUpdate = new List<Job_Application__c>();
    
    for (Job_Application__c jobApplication : jobApplicationsMap.values()) {
        Boolean reviewProvided = false;
        
        for (Review__c review : jobApplication.Review__r) {
            if (review.Rating__c != null) {
                reviewProvided = true;
                break;
            }
        }
        
        String reviewProvidedValue = reviewProvided ? 'Yes' : 'No';
        
        if (jobApplication.Review_Provided__c != reviewProvidedValue) {
            jobApplication.Review_Provided__c = reviewProvidedValue;
            jobApplicationsToUpdate.add(jobApplication);
        }
    }
    
    if (!jobApplicationsToUpdate.isEmpty()) {
        update jobApplicationsToUpdate;
    }
}