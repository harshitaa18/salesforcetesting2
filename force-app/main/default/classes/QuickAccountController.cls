public with sharing class QuickAccountController {
    
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        
        // 1. INTEGRATION HEALTH (4 second latency)
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://httpbin.org/delay/4'); 
            req.setMethod('GET');
            new Http().send(req);
        } catch(Exception e) {
            System.debug('Callout failed: ' + e.getMessage());
        }

        // 2. UNCOMMITTED WORK PENDING (DML before Callout - Caught safely)
        insert new Contact(LastName = 'Trigger Callout Error');
        try {
            HttpRequest req2 = new HttpRequest();
            req2.setEndpoint('https://httpbin.org/get');
            req2.setMethod('GET');
            new Http().send(req2);
        } catch(Exception e) {
            System.debug('Uncommitted Work Caught: ' + e.getMessage());
        }

        // 3. HEAP SIZE WARNING (~5MB)
        String giantString = '';
        for(Integer i=0; i<250000; i++) {
            giantString += 'Jataka_Load_Testing_String_';
        }

        // 4. SOQL QUERIES & SOQL IN LOOPS WARNING (90 queries)
        List<Account> dummyList;
        for(Integer i=0; i<90; i++) {
            dummyList = [SELECT Id FROM Account LIMIT 1];
        }

        // 5. QUERY ROWS (45,000 rows)
        List<User> users = [SELECT Id FROM User LIMIT 45000];

        // 6. ASYNC IMPACT (Enqueue 40 Jobs)
        for(Integer i=0; i<40; i++) {
            System.enqueueJob(new DummyQueueable());
        }

        // 7. DML STATEMENTS & DML IN LOOPS (130 statements)
        for(Integer i=0; i<130; i++) {
            insert new Contact(LastName = 'Chaos ' + i);
        }

        // 8. DML ROWS (8,000 rows)
        List<Contact> bulkContacts = new List<Contact>();
        for(Integer i=0; i<8000; i++) {
            bulkContacts.add(new Contact(LastName='Bulk ' + i));
        }
        insert bulkContacts;

        // 9. CPU TIME WARNING (Burn ~4 seconds manually, leaving room for the Flow)
        Long startTime = System.now().getTime();
        while(System.now().getTime() - startTime < 4000) {
            Double x = Math.sqrt(Math.random() * 10000);
        }

        // 10. TRIGGER THE FLOW!
        // We do this last so all previous limits are stacked up, 
        // but we still have enough CPU left to survive the Flow loop.
        Account acc = new Account(Name = name, Phone = phone);
        insert acc;
        
        return acc;
    }

    public class DummyQueueable implements Queueable {
        public void execute(QueueableContext context) {}
    }
}