public with sharing class QuickAccountController {
    
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        
        // 1. INTEGRATION HEALTH (2 second latency)
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://httpbin.org/delay/2'); 
            req.setMethod('GET');
            new Http().send(req);
        } catch(Exception e) {}

        // 2. SOQL QUERIES (Burn 90 out of 100)
        List<Account> dummyList;
        for(Integer i = 0; i < 90; i++) {
            dummyList = [SELECT Id FROM Account LIMIT 1];
        }

        // 3. DML STATEMENTS (Burn 140 out of 150)
        for(Integer i = 0; i < 140; i++) {
            insert new Contact(LastName = 'Chaos ' + i);
        }

        // 4. ASYNC IMPACT (Enqueue 40 out of 50 jobs)
        for(Integer i = 0; i < 40; i++) {
            System.enqueueJob(new DummyQueueable());
        }

        // 5. ACTUAL WORK (Save the account so the UI gets a success message)
        Account acc = new Account(Name = name, Phone = phone);
        insert acc;

        // 6. SAFE CPU & HEAP BURN (Placed ABSOLUTELY LAST)
        // This loops for exactly 8.5 seconds to hit 85% CPU, 
        // safely adding items to a list to trigger the Heap warning.
        List<String> heapBurner = new List<String>();
        Long startTime = System.now().getTime();
        
        while(System.now().getTime() - startTime < 8500) {
            // Burn CPU
            Double x = Math.sqrt(Math.random() * 10000);
            
            // Burn Heap safely up to ~5MB
            if(Limits.getHeapSize() < 5000000) {
                heapBurner.add(String.valueOf(x) + 'Jataka_Memory_Blocker_Data_String_');
            }
        }

        return acc;
    }

    // Dummy class to trigger Async limits
    public class DummyQueueable implements Queueable {
        public void execute(QueueableContext context) {}
    }
}