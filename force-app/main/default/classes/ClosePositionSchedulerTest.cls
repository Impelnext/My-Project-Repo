@isTest
public class ClosePositionSchedulerTest {

    @testSetup
    static void setupData() {
        // Create test data - Positions__c records
        List<Positions__c> positions = new List<Positions__c>();
        
        for(Integer i = 0; i < 5; i++) {
            positions.add(new Positions__c(Close_Position__c = false, CreatedDate = System.today().addDays(-i)));
        }

        // Insert the positions
        insert positions;
    }

    @isTest
    static void testExecute() {
        // Verify initial state
        List<Positions__c> initialPositions = [SELECT Id, Close_Position__c FROM Positions__c WHERE Close_Position__c = false];
        System.assertEquals(5, initialPositions.size(), 'Initially, there should be 5 open positions.');

        // Instantiate and execute the scheduler
        Test.startTest();
        ClosePositionScheduler scheduler = new ClosePositionScheduler();
        String jobId = System.schedule('Test Job', '0 0 0 15 8 ? 2024', scheduler);  // Schedule the job to execute immediately
        Test.stopTest();

        // Verify the outcome
        List<Positions__c> updatedPositions = [SELECT Id, Close_Position__c FROM Positions__c WHERE Close_Position__c = true];
        System.assertEquals(5, updatedPositions.size(), 'All positions should be closed.');
    }
}
