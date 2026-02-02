import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import applyDiscount from '@salesforce/apex/DiscountService.applyDiscount';

export default class DiscountButton extends LightningElement {
    @api recordId;

    async handleClick() {
        try {
            const newAmount = await applyDiscount({ oppId: this.recordId });
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Discount Applied',
                    message: `Opportunity Amount updated to ${newAmount}`,
                    variant: 'success'
                })
            );
        } catch (e) {
            const message =
                e?.body?.message ||
                e?.message ||
                'Unknown error while applying discount.';
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Discount Failed',
                    message,
                    variant: 'error'
                })
            );
        }
    }
}


