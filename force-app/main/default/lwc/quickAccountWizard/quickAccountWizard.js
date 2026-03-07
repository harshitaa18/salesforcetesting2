import { LightningElement, track } from 'lwc';
import createAccount from '@salesforce/apex/QuickAccountController.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class QuickAccountWizard extends LightningElement {
    @track message = '';
    @track selectedIndustry;

    // --- INTENTIONAL SABOTAGE FOR JATAKA DEMO ---
    connectedCallback() {
        console.log("Simulating heavy JavaScript execution...");
        const start = new Date().getTime();
        // Block the main UI thread for 4.5 seconds
        while (new Date().getTime() < start + 4500) {
            // Do nothing, just freeze the browser rendering
        }
        console.log("Heavy execution finished.");
    }
    // --------------------------------------------

    industryOptions =[
        { label: 'Technology', value: 'Technology' },
        { label: 'Finance', value: 'Finance' },
        { label: 'Healthcare', value: 'Healthcare' },
        { label: 'Retail', value: 'Retail' },
        { label: 'Manufacturing', value: 'Manufacturing' },
        { label: 'Education', value: 'Education' },
        { label: 'Consulting', value: 'Consulting' },
        { label: 'Real Estate', value: 'RealEstate' }
    ];

    handleIndustryChange(event) {
        this.selectedIndustry = event.target.value;
    }

    handleNameChange(event) {
        this.accountName = event.target.value;
    }

    handlePhoneChange(event) {
        this.accountPhone = event.target.value;
    }

    @track accountName = '';
    @track accountPhone = '';

    handleCreate() {
        const nameInput = this.template.querySelector('[data-id="accName"]');
        const phoneInput = this.template.querySelector('[data-id="accPhone"]');
        
        const name = nameInput.value || this.accountName;
        const phone = phoneInput.value || this.accountPhone;

        if (!name) {
            nameInput.reportValidity();
            return;
        }

        createAccount({ name: name, phone: phone })
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
                this.accountName = '';
                this.accountPhone = '';
                this.selectedIndustry = null;
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