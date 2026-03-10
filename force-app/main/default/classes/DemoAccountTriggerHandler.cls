public class DemoAccountTriggerHandler {
    
    public static void handleBeforeInsert(List<Account> newList) {
        
        // 1. MASSIVE HEAP BLOAT (Let's push it to ~4MB)
        String giantString = '';
        for(Integer i = 0; i < 50000; i++) {
            giantString += 'Jataka_Performance_Testing_Data_Bloat_';
        }
        System.debug('Heap bloat length: ' + giantString.length());

        for (Account acc : newList) {
            
            // 2. FORCE THE LOOP ISSUE
            // By putting a literal loop here, we force the 1 record to execute SOQL 55 times
            for(Integer j = 0; j < 10; j++) {
                // BAD: SOQL inside a loop
                List<Contact> randomContacts = [SELECT Id FROM Contact LIMIT 1];
                
                // BAD: DML inside a loop
                Contact c = new Contact(LastName = 'AutoContact ' + j);
                insert c; 
            }
        }
    }
}