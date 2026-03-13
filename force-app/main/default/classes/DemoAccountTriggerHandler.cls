public class DemoAccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> newList) {
        for(Account acc : newList) {
            // Add a SOQL query here. 
            // We want to see if Jataka catches this query taking up limits!
            List<Contact> dummyCheck = [SELECT Id FROM Contact LIMIT 1];
        }
    }
}