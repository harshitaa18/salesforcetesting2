public with sharing class QuickAccountController {
    
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        // 1. Heap Burn
        String giantString = '';
        for(Integer i=0; i<250000; i++) { giantString += 'Jataka_String_'; }

        // 2. SOQL Burn
        List<Account> dummyList;
        for(Integer i=0; i<95; i++) { dummyList = [SELECT Id FROM Account LIMIT 1]; }

        // 3. DML Burn
        for(Integer i=0; i<140; i++) { insert new Contact(LastName = 'Chaos ' + i); }

        // 4. CPU Burn (Lowered to 8 seconds so it warns, but survives to save the log!)
        Long startTime = System.now().getTime();
        while(System.now().getTime() - startTime < 8000) { Double x = Math.sqrt(Math.random() * 10000); }

        Account acc = new Account(Name = name, Phone = phone);
        insert acc;
        return acc;
    }

    public class DummyQueueable implements Queueable {
        public void execute(QueueableContext context) {}
    }
}