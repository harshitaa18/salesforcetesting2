public class DemoAccountTriggerHandler {
    
    public static void handleBeforeInsert(List<Account> newList) {
        
        // 4. HEAP SIZE BLOAT TEST
        // Create a massive string in memory to push Heap Size utilization up
        String giantString = '';
        for(Integer i = 0; i < 15000; i++) {
            giantString += 'Jataka_Performance_Testing_String_Bloat_Data_';
        }
        System.debug('Heap bloat length: ' + giantString.length());

        // 5. SOQL & DML IN LOOPS TEST (The #1 Salesforce Killer)
        for (Account acc : newList) {
            
            // BAD: SOQL inside a loop
            List<Contact> randomContacts = [SELECT Id FROM Contact LIMIT 1];
            
            // BAD: DML inside a loop
            Contact c = new Contact(LastName = 'AutoContact for ' + acc.Name);
            insert c; 
        }
    }
}