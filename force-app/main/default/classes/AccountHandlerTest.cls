@isTest
public class AccountHandlerTest {

    @testSetup
    static void setupTestData() {
        // Create test Account records
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name = 'Test Account 1', Industry = 'Technology'));
        accounts.add(new Account(Name = 'Test Account 2', Industry = 'Finance'));
        insert accounts;
    }

    @isTest
    static void testUpdateAccountIndustry() {
        // Verify initial state11
        List<Account> initialAccounts = [SELECT Id, Industry FROM Account];
        System.assertEquals(2, initialAccounts.size(), 'There should be 2 accounts in the system.');
        System.assertEquals('Technology', initialAccounts[0].Industry);
        System.assertEquals('Finance', initialAccounts[1].Industry);

        // Instantiate the handler and call the method
        Test.startTest();  // This should work as a static method call
        AccountHandler handler = new AccountHandler();
        handler.updateAccountIndustry('Healthcare');
        Test.stopTest();  // This should also work as a static method call

        // Verify the update
        List<Account> updatedAccounts = [SELECT Id, Industry FROM Account];
        for (Account acc : updatedAccounts) {
            System.assertEquals('Healthcare', acc.Industry, 'The Industry field should be updated to Healthcare.');
        }
    }
}