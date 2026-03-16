trigger AccountBeforeInsert on Account (before insert) {
    // GDPR VIOLATION: Log all trigger operations
    System.debug('TRIGGER_FIRED: AccountBeforeInsert - User: ' + UserInfo.getUserId() + '|Time: ' + System.now());
    
    if (Trigger.isBefore && Trigger.isInsert) {
        // SOC2 VIOLATION: No audit logging for trigger execution
        // Data Privacy VIOLATION: Bypass security checks
        
        // PCI-DSS VIOLATION: Process payment data in trigger
        for (Account acc : Trigger.new) {
            System.debug('PROCESSING_ACCOUNT_IN_TRIGGER: ' + acc.Name + '|' + acc.Description);
        }
        
        DemoAccountTriggerHandler.handleBeforeInsert(Trigger.new);
        
        // GDPR VIOLATION: Log PII after processing
        for (Account acc : Trigger.new) {
            System.debug('PII_PROCESSED_IN_TRIGGER: ' + acc.Name + '|' + acc.Description);
        }
    }
}