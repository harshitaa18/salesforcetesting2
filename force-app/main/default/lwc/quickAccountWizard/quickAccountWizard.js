import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class QuickAccountWizard extends LightningElement {
    @track successMessage = '';
    @track errorMessage = '';

    formData = {
        name: '',
        accNumber: '',
        phone: '',
        website: '',
        industry: '',
        revenue: '', 
        employees: null,
        city: ''
    };

    handleInputChange(event) {
        const fieldMap = {
            'accName': 'name',
            'accNumber': 'accNumber',
            'accPhone': 'phone',
            'accWebsite': 'website',
            'accIndustry': 'industry',
            'accRevenue': 'revenue',
            'accEmployees': 'employees',
            'accCity': 'city'
        };

        const fieldId = event.target.dataset.id;
        const key = fieldMap[fieldId];
        
        if (key) {
            this.formData[key] = event.target.value;
        }
    }

    handleCreate() {
        this.successMessage = '';
        this.errorMessage = '';

        const nameInput = this.template.querySelector('[data-id="accName"]');
        if (!this.formData.name) {
            nameInput.setCustomValidity("Account Name is required.");
            nameInput.reportValidity();
            return;
        } else {
            nameInput.setCustomValidity("");
            nameInput.reportValidity();
        }

        // Simulate account creation without Apex
        setTimeout(() => {
            this.successMessage = `Account "${this.formData.name}" would be created successfully! (Demo Mode)`;
            
            // Clear form
            this.template.querySelectorAll('lightning-input, lightning-combobox').forEach(input => {
                input.value = null;
            });
            this.formData = {};
            
            // Show success toast
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account form validated successfully!',
                    variant: 'success'
                })
            );
        }, 1000);
    }
}