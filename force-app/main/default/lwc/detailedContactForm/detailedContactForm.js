import { LightningElement, track } from 'lwc';
import createContact from '@salesforce/apex/DetailedContactController.createContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DetailedContactForm extends LightningElement {
    @track message = '';
    @track messageVariant = 'success';
    @track messageIcon = 'utility:success';

    leadSourceOptions = [
        { label: 'Web', value: 'Web' },
        { label: 'Phone Inquiry', value: 'Phone Inquiry' },
        { label: 'Partner Referral', value: 'Partner Referral' },
        { label: 'Purchased List', value: 'Purchased List' },
        { label: 'Other', value: 'Other' },
        { label: 'Trade Show', value: 'Trade Show' },
        { label: 'Word of mouth', value: 'Word of mouth' },
        { label: 'Advertisement', value: 'Advertisement' }
    ];

    handleCreate() {
        // Collect all form data
        const formData = this.collectFormData();
        
        // Validate required fields
        if (!this.validateForm(formData)) {
            return;
        }

        // Prepare contact data for Apex
        const contactData = {
            firstName: formData.firstName,
            lastName: formData.lastName,
            email: formData.email,
            phone: formData.phone,
            birthDate: formData.birthDate,
            company: formData.company,
            title: formData.title,
            department: formData.department,
            street: formData.street,
            city: formData.city,
            state: formData.state,
            postalCode: formData.postalCode,
            country: formData.country,
            notes: formData.notes,
            leadSource: formData.leadSource,
            newsletter: formData.newsletter
        };

        createContact({ contactData: contactData })
            .then(result => {
                this.showMessage(`Success! Created contact: ${result.Name}`, 'success', 'utility:success');
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created successfully!',
                        variant: 'success'
                    })
                );
                // Clear form after successful creation
                this.clearForm();
            })
            .catch(error => {
                this.showMessage('Error creating contact: ' + error.body.message, 'error', 'utility:error');
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    handleClear() {
        this.clearForm();
        this.message = '';
    }

    collectFormData() {
        const inputs = this.template.querySelectorAll('lightning-input, lightning-textarea, lightning-combobox');
        const formData = {};
        
        inputs.forEach(input => {
            const dataId = input.dataset.id;
            if (input.type === 'checkbox') {
                formData[dataId] = input.checked;
            } else {
                formData[dataId] = input.value;
            }
        });
        
        return formData;
    }

    validateForm(formData) {
        const requiredFields = ['firstName', 'lastName'];
        let isValid = true;

        requiredFields.forEach(field => {
            const input = this.template.querySelector(`[data-id="${field}"]`);
            if (!formData[field] || formData[field].trim() === '') {
                input.reportValidity();
                isValid = false;
            }
        });

        // Email validation if provided
        if (formData.email && !this.isValidEmail(formData.email)) {
            const emailInput = this.template.querySelector('[data-id="email"]');
            emailInput.setCustomValidity('Please enter a valid email address');
            emailInput.reportValidity();
            isValid = false;
        }

        return isValid;
    }

    isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    clearForm() {
        const inputs = this.template.querySelectorAll('lightning-input, lightning-textarea, lightning-combobox');
        inputs.forEach(input => {
            if (input.type === 'checkbox') {
                input.checked = false;
            } else {
                input.value = '';
            }
            // Clear any custom validity messages
            input.setCustomValidity('');
        });
    }

    showMessage(message, variant, iconName) {
        this.message = message;
        this.messageVariant = variant;
        this.messageIcon = iconName;
    }
}
