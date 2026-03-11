public with sharing class QuickAccountController {
    
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        
        // 1. INTEGRATION HEALTH (4 second latency)
        // Note: For this to work, you MUST add https://httpbin.org to your Remote Site Settings in Salesforce!
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://httpbin.org/delay/4'); 
            req.setMethod('GET');
            new Http().send(req);
        } catch(Exception e) {
            System.debug('Callout failed: ' + e.getMessage());
        }

        // 2. HEAP SIZE WARNING (>4MB)
        String giantString = '';
        for(Integer i=0; i<300000; i++) {
            giantString += 'Jataka_Load_Testing_String_';
        }

        // 3. SOQL QUERIES & SOQL IN LOOPS WARNING (~90 queries)
        List<Account> dummyList;
        for(Integer i=0; i<90; i++) {
            dummyList = [SELECT Id FROM Account LIMIT 1];
        }

        // 4. QUERY ROWS (Fetch up to 45,000 rows)
        List<User> users = [SELECT Id FROM User LIMIT 45000];

        // 5. CPU TIME WARNING (Burn ~8.5 seconds)
        Long startTime = System.now().getTime();
        while(System.now().getTime() - startTime < 8500) {
            Double x = Math.sqrt(Math.random() * 10000);
        }

        // 6. ASYNC IMPACT (Enqueue 40 Jobs)
        for(Integer i=0; i<40; i++) {
            System.enqueueJob(new DummyQueueable());
        }

        // 7. DML STATEMENTS & DML IN LOOPS (140 statements)
        for(Integer i=0; i<140; i++) {
            insert new Contact(LastName = 'Chaos ' + i);
        }

        // 8. DML ROWS (Insert 8,000 records)
        List<Contact> bulkContacts = new List<Contact>();
        for(Integer i=0; i<8000; i++) {
            bulkContacts.add(new Contact(LastName='Bulk ' + i));
        }
        insert bulkContacts;

        // 9. UNCOMMITTED WORK PENDING (Callout after DML)
        try {
            HttpRequest req2 = new HttpRequest();
            req2.setEndpoint('https://httpbin.org/get');
            req2.setMethod('GET');
            new Http().send(req2);
        } catch(Exception e) {
            System.debug(e.getMessage());
        }

        // Finally, actually create the account so the UI proceeds
        Account acc = new Account(Name = name, Phone = phone);
        insert acc;
        return acc;
    }

    // Dummy class to trigger Async limits
    public class DummyQueueable implements Queueable {
        public void execute(QueueableContext context) {}
    }
}