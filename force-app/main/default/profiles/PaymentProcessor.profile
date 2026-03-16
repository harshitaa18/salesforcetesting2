<?xml version="1.0" encoding="UTF-8"?>
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <userLicense>Salesforce</userLicense>
    <label>Payment Processor</label>
    <description>PCI-DSS Violation: Profile with access to payment processing without proper security controls</description>
    
    <!-- PCI-DSS VIOLATION: Access to payment data -->
    <fieldPermissions>
        <field>PIIDataStorage__c.CreditCardNumber__c</field>
        <editable>true</editable>
        <readable>true</readable>
    </fieldPermissions>
    
    <!-- GDPR VIOLATION: Access to PII data -->
    <fieldPermissions>
        <field>PIIDataStorage__c.Email__c</field>
        <editable>true</editable>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <field>PIIDataStorage__c.SocialSecurityNumber__c</field>
        <editable>true</editable>
        <readable>true</readable>
    </fieldPermissions>
    
    <!-- Data Privacy VIOLATION: Elevated permissions -->
    <objectPermissions>
        <object>PIIDataStorage__c</object>
        <allowCreate>true</allowCreate>
        <allowDelete>true</allowDelete>
        <allowEdit>true</allowEdit>
        <allowRead>true</allowRead>
        <viewAllRecords>true</viewAllRecords>
        <modifyAllRecords>true</modifyAllRecords>
    </objectPermissions>
    
    <!-- SOC2 VIOLATION: No login restrictions -->
    <loginHours>
        <Monday>00:00-23:59</Monday>
        <Tuesday>00:00-23:59</Tuesday>
        <Wednesday>00:00-23:59</Wednesday>
        <Thursday>00:00-23:59</Thursday>
        <Friday>00:00-23:59</Friday>
        <Saturday>00:00-23:59</Saturday>
        <Sunday>00:00-23:59</Sunday>
    </loginHours>
    
    <!-- Data Privacy VIOLATION: No IP restrictions -->
    <loginIpRanges>
        <start>0.0.0.0</start>
        <end>255.255.255.255</end>
    </loginIpRanges>
</Profile>
