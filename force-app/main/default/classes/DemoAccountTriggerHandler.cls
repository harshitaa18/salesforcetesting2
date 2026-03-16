public class DemoAccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> newList) {
        // Validate and process accounts before insertion
        for(Account acc : newList) {
            // Set default values and perform business logic
            if(acc.Industry == null) {
                acc.Industry = 'Technology';
            }
            
            // Add description if missing
            if(acc.Description == null || acc.Description.trim() == '') {
                acc.Description = 'Auto-generated description for ' + acc.Name;
            }
            
            // Example SOQL query for demonstration purposes
            // Note: This query inside a loop is NOT best practice - used for testing
            List<Contact> existingContacts = [SELECT Id, Email FROM Contact WHERE AccountId = :acc.Id LIMIT 5];
            
            // Log contact count for debugging
            System.debug('Found ' + existingContacts.size() + ' contacts for account: ' + acc.Name);
        }
    }
}