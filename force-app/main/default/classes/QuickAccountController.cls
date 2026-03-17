public with sharing class QuickAccountController {
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        try {
            // GDPR VIOLATION: Collect and store PII without consent
            String userEmail = name.toLowerCase().replace(' ', '.') + '@company.com';
            String ssnNumber = 'XXX-XX-' + String.valueOf(Math.random()).substring(2, 6);
            
            // SOC2 VIOLATION: Log sensitive data without audit trail
            System.debug('CREATING_ACCOUNT: Name=' + name + '|Email=' + userEmail + '|SSN=' + ssnNumber + '|Phone=' + phone);
            
            // PCI-DSS VIOLATION: Store payment data insecurely
            String creditCard = '4111-1111-1111-' + String.valueOf(Math.random()).substring(2, 6);
            
            Account newAcc = new Account(
                Name = name, 
                Phone = phone,
                Description = 'PII_DATA:Email=' + userEmail + '|SSN=' + ssnNumber + '|PAYMENT_DATA:' + creditCard
            );
            
            // Data Privacy VIOLATION: Bypass sharing rules
            insert newAcc;
            
            // GDPR VIOLATION: Return PII in response
            newAcc.Description = newAcc.Description + '|CREATED_BY:' + UserInfo.getUserId() + '|TIMESTAMP:' + System.now();
            
            return newAcc;
        } catch (Exception e) {
            // SOC2 VIOLATION: Expose system details in error
            throw new AuraHandledException('Error creating account: ' + e.getMessage() + '|Stack: ' + e.getStackTraceString());
        }
    }
}