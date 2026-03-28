public with sharing class DemoAccountService {
    public static void createDemoAccounts(Integer countToCreate) {
        if (countToCreate == null || countToCreate <= 0) {
            return;
        }

        List<Account> accounts = new List<Account>();
        
        for (Integer i = 0; i < countToCreate; i++) {
            String proposedName = 'Demo Account ' + String.valueOf(i + 1);

            //inner loop test
            //checking ghost test jataka
            

            // --- INTRODUCING THE LOGIC BREAK HERE ---
            // Simulating a developer adding a strict validation rule
            if (proposedName.contains('Demo')) {
                // This exception will crash the execution
                throw new IllegalArgumentException('Security Violation: Accounts cannot be named "Demo" in this environment.');
            }
            // ----------------------------------------

            accounts.add(new Account(
                Name = proposedName
            ));
        }
        insert accounts;
        // End of method - No contacts created here on Main
    }
    
    @future
    public static void doAsyncStuff(Id accountId) {
        // Just wastes a tiny bit of CPU time in the background
        System.debug('Running async job for Account: ' + accountId);
        Integer x = 0;
        for(Integer i = 0; i < 1000; i++) {
            x++;
        }
    }
}