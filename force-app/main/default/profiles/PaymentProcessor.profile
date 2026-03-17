<?xml version="1.0" encoding="UTF-8"?>
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <userLicense>Salesforce</userLicense>
    <description>PCI-DSS Violation: Profile with access to payment processing without proper security controls</description>
    
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
    
    </Profile>
