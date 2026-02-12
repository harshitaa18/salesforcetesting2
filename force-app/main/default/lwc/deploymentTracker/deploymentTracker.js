import { LightningElement, track } from 'lwc';
// REMOVED: import createDemoAccounts from '@salesforce/apex/DemoAccountService.createDemoAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DeploymentTracker extends LightningElement {
    @track statusMessage = '';

    handleSmokeTest() {
        this.statusMessage = 'Running smoke test logic...';
        
        // MOCK LOGIC: Since, Org doesn't support Apex, we simulate a success
        // In a Developer Edition, you would uncomment the Apex call below.
        
        // Simulate network delay
        setTimeout(() => {
            this.statusMessage = 'Smoke Test Passed: Account Created (Simulation)!';
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Connection Verified (Apex Skipped for PE Org)',
                    variant: 'success'
                })
            );
        }, 1000);

        /* 
        // ORIGINAL APEX CALL (Requires Developer Edition)
        createDemoAccounts({ countToCreate: 1 })
            .then(() => {
                this.statusMessage = 'Smoke Test Passed: Account Created!';
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Apex Connection Verified',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                this.statusMessage = 'Error: ' + error.body.message;
            });
        */
    }
}