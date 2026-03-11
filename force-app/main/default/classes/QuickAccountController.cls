public with sharing class QuickAccountController {
    
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        
        // 1. INTEGRATION HEALTH (2 second latency to trigger warning but save time)
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://httpbin.org/delay/2'); 
            req.setMethod('GET');
            new Http().send(req);
        } catch(Exception e) {}

        // 2. SOQL QUERIES (Burn 95 out of 100)
        List<Account> dummyList;
        for(Integer i = 0; i < 95; i++) {
            dummyList = [SELECT Id FROM Account LIMIT 1];
        }

        // 3. DML STATEMENTS (Burn 140 out of 150)
        for(Integer i = 0; i < 140; i++) {
            insert new Contact(LastName = 'Chaos ' + i);
        }

        // 4. ASYNC IMPACT (Enqueue 45 out of 50 jobs)
        for(Integer i = 0; i < 45; i++) {
            System.enqueueJob(new DummyQueueable());
        }

        // 5. HEAP SIZE (Burn ~4MB)
        String giantString = '';
        for(Integer i = 0; i < 150000; i++) {
            giantString += 'Jataka_Load_Testing_String_';
        }

        // 6. CPU BURN (Placed LAST! Burn 8.5 seconds so it hits WARNING but doesn't crash)
        Long startTime = System.now().getTime();
        while(System.now().getTime() - startTime < 8500) {
            Double x = Math.sqrt(Math.random() * 10000);
        }

        // 7. Finally, actually create the account so the UI succeeds
        Account acc = new Account(Name = name, Phone = phone);
        insert acc;
        return acc;
    }

    // Dummy class to trigger Async limits
    public class DummyQueueable implements Queueable {
        public void execute(QueueableContext context) {}
    }
}