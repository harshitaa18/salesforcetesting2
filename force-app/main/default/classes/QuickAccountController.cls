public with sharing class QuickAccountController {

    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        
        // ---------------------------------------------------------
        // TEST 1: FAIL "Data Skew & Locks"
        // ---------------------------------------------------------
        // The salesforce_profiler.py uses a regex that looks for this exact string 
        // in the debug logs. We can trigger it just by debugging the string!
        System.debug('Simulating row lock timeout: UNABLE_TO_LOCK_ROW');


        // ---------------------------------------------------------
        // TEST 2: FAIL "Integration Health" (> 3s Callout)
        // ---------------------------------------------------------
        // We use httpbin.org/delay/4 to hold the connection open for 4 seconds.
        // NOTE: You must add 'https://httpbin.org' to Remote Site Settings in 
        // your Salesforce org, or this will fail instantly and won't take 3 seconds!
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://httpbin.org/delay/4'); 
            req.setMethod('GET');
            HttpResponse res = http.send(req);
        } catch (Exception e) {
            System.debug('Callout failed. Did you add httpbin.org to Remote Site Settings?');
        }


        // ---------------------------------------------------------
        // TEST 3: FAIL "Async Impact (Flex Queue)"
        // ---------------------------------------------------------
        // The one-backend queries AsyncApexJob before and after the test.
        // Enqueuing 15 jobs will trigger the > 10 threshold.
        for(Integer i = 0; i < 15; i++) {
            System.enqueueJob(new DummyQueueable());
        }


        // ---------------------------------------------------------
        // Original functional logic 
        // (Must be AT THE END because Salesforce doesn't allow Callouts after DML)
        // ---------------------------------------------------------
        Account acc = new Account(Name = name, Phone = phone);
        insert acc;
        return acc;
    }
}