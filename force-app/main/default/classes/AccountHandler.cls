public class AccountHandler {
    public void updateAccountIndustry(String industry) {
        // Query all accounts
        List<Account> accounts = [SELECT Id, Industry FROM Account];

        // Update the industry field for each account
        for (Account acc : accounts) {
            acc.Industry = industry;
        }

        // Perform the update
        if (!accounts.isEmpty()) {
            update accounts;
        }
    }
}