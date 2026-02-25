import { LightningElement, track } from 'lwc';
import createAccount from '@salesforce/apex/QuickAccountController.createAccount';
import fetchErpData from '@salesforce/apex/QuickAccountController.fetchErpData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class QuickAccountWizard extends LightningElement {
    @track message = '';
    @track erpId = '';
    @track isLoading = false;

    // --- PHASE 4: INTEGRATION TEST ---
    handleSync() {
        this.isLoading = true; // Bot must wait for this to disappear
        this.message = 'Contacting external ERP system...';

        const name = this.template.querySelector('[data-id="accName"]').value;

        // Call Apex which calls the External API
        fetchErpData({ accountName: name })
            .then(result => {
                this.erpId = result; // Should populate with "MOCK-999" during test
                this.message = 'ERP Sync Complete!';
                this.isLoading = false;
            })
            .catch(error => {
                this.message = 'ERP Sync Failed: ' + (error.body ? error.body.message : error.message);
                this.isLoading = false;
            });
    }

    handleCreate() {
        const nameInput = this.template.querySelector('[data-id="accName"]');
        const phoneInput = this.template.querySelector('[data-id="accPhone"]');
        
        const name = nameInput.value;
        const phone = phoneInput.value;

        if (!name) {
            nameInput.reportValidity();
            return;
        }

        createAccount({ name: name, phone: phone, taxId: this.erpId })
            .then(result => {
                this.message = `Success! Created account: ${result.Name}`;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created successfully!',
                        variant: 'success'
                    })
                );
                // Clear inputs
                nameInput.value = '';
                phoneInput.value = '';
                this.erpId = '';
            })
            .catch(error => {
                this.message = 'Error creating account';
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}