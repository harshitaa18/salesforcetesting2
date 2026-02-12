import { LightningElement, track } from 'lwc';
// 1. UNCOMMENT THE APEX IMPORT
import createDemoAccounts from '@salesforce/apex/DemoAccountService.createDemoAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DeploymentTracker extends LightningElement {
    @track statusMessage = '';

    handleSmokeTest() {
        this.statusMessage = 'Running smoke test (Apex)...';
        
        // 2. USE ACTUAL APEX CALL (Removes the setTimeout simulation)
        // This forces the server to do work, generating a Debug Log for the profiler.
        createDemoAccounts({ countToCreate: 5 }) 
            .then(() => {
                this.statusMessage = 'Smoke Test Passed: Accounts Created via Apex!';
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Apex Logic Executed Successfully',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                this.statusMessage = 'Error: ' + (error.body ? error.body.message : error.message);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Apex Failed',
                        variant: 'error'
                    })
                );
            });
    }
}