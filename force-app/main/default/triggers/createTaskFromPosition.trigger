trigger createTaskFromPosition on Positions__c (after insert) {
    List<Task> taskList = new List<Task>();
    for(Positions__c postionRecord : Trigger.new){
        if(postionRecord.Status__c == 'New Position'){
            Task task = new task();
            task.Subject = 'Please Review New Position';
            task.Description = 'A new position has been created and requires review.';
            task.Status = 'Not Started';
            task.WhatId = postionRecord.id;
         
            taskList.add(task);
        }
    }
    if(!taskList.isEmpty()){
        insert taskList;
    }
    
    
}