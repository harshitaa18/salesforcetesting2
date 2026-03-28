public with sharing class QuickAccountController {
    
    @AuraEnabled
    public static Account createAccount(String name, String phone) {

        // 1️⃣ SAVE ACCOUNT FIRST (so UI succeeds)
        Account acc = new Account(Name = name, Phone = phone);
        insert acc;

        // 2️⃣ INTEGRATION HEALTH (2 second latency)
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://httpbin.org/delay/2'); 
            req.setMethod('GET');
            new Http().send(req);
        } catch(Exception e) {}

        // 3️⃣ SOQL QUERIES
        List<Account> dummyList;
        for(Integer i = 0; i < 90; i++) {
            dummyList = [SELECT Id FROM Account LIMIT 1];
        }

        // 4️⃣ DML STATEMENTS
        for(Integer i = 0; i < 140; i++) {
            insert new Contact(LastName = 'Chaos ' + i);
        }

        // 5️⃣ ASYNC IMPACT
        for(Integer i = 0; i < 40; i++) {
            System.enqueueJob(new DummyQueueable());
        }

        // 6️⃣ CPU + HEAP burn
        List<String> heapBurner = new List<String>();
        Long startTime = System.now().getTime();
        
        while(System.now().getTime() - startTime < 8500) { // reduced from 8500
            Double x = Math.sqrt(Math.random() * 10000);
            
            if(Limits.getHeapSize() < 5000000) {
                heapBurner.add(String.valueOf(x) + 'Jataka_Memory_Blocker_Data_String_');
            }
        }

        return acc;
    }

    public class DummyQueueable implements Queueable {
        public void execute(QueueableContext context) {}
    }
}