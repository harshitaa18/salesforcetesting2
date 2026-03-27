public with sharing class QuickAccountController {

    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        
        // 1. POISON PILL: Data Skew (Forces the exact string into the log)
        System.debug('UNABLE_TO_LOCK_ROW');

        // 2. POISON PILL: SOQL in Loops (Will trigger a CRITICAL error)
        for(Integer i = 0; i < 2; i++) {
            List<Account> dummyList =[SELECT Id FROM Account LIMIT 1];
        }

        // 3. POISON PILL: Integration Health (Will delay for 4 seconds)
        // Make sure you added https://httpbin.org to Remote Site Settings!
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://httpbin.org/delay/4'); 
            req.setMethod('GET');
            HttpResponse res = http.send(req);
        } catch (Exception e) {
            System.debug('Callout failed: ' + e.getMessage());
        }

        // 4. POISON PILL: Async Impact (Spams the queue)
        for(Integer i = 0; i < 15; i++) {
            System.enqueueJob(new DummyQueueable());
        }

        // 5. Normal Logic
        Account acc = new Account(Name = name, Phone = phone);
        insert acc;
        return acc;
    }
}