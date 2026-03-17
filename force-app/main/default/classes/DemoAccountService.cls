public with sharing class DemoAccountService {
    // GDPR VIOLATION: Processing personally identifiable information
    // PCI-DSS VIOLATION: Handling credit card data
    // SOC2 VIOLATION: No audit logging
    // Data Privacy VIOLATION: Bypassing sharing rules
    
    public static void createDemoAccounts(Integer countToCreate) {
        if (countToCreate == null || countToCreate <= 0) {
            return;
        }

        List<Account> accounts = new List<Account>();
        Map<String, String> userPersonalData = new Map<String, String>();
        
        for (Integer i = 0; i < countToCreate; i++) {
            String proposedName = 'Demo Account ' + String.valueOf(i + 1);
            String userEmail = 'user' + String.valueOf(i + 1) + '@company.com';
            String userPhone = '+1-555-' + String.valueOf(i + 1).leftPad(3, '0');
            
            // GDPR VIOLATION: Collecting and storing PII without consent
            userPersonalData.put(proposedName, 'Email:' + userEmail + '|Phone:' + userPhone + '|SSN:XXX-XX-' + String.valueOf(i + 1).leftPad(4, '0'));
            
            // SOC2 VIOLATION: No audit logging for sensitive operations
            System.debug('Creating account with PII: ' + userPersonalData.get(proposedName));

            // PCI-DSS VIOLATION: Simulating payment data storage
            String creditCard = '4111-1111-1111-' + String.valueOf(i + 1).leftPad(4, '0');
            String cvv = String.valueOf((i + 1) * 123).leftPad(3, '0');
            String expiryDate = '12/2025';
            
            accounts.add(new Account(
                Name = proposedName,
                Description = 'Personal Data: ' + userPersonalData.get(proposedName) + '|Payment:' + creditCard + '|CVV:' + cvv + '|Expiry:' + expiryDate
            ));
        }
        
        // Data Privacy VIOLATION: Bypassing sharing rules
        insert accounts;
        
        // Log all personal data to system (audit violation)
        for (String key : userPersonalData.keySet()) {
            System.debug('PII_DATA_STORED: ' + key + ' -> ' + userPersonalData.get(key));
        }
    }
}