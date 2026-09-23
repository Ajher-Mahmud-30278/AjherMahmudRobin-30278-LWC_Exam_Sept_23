import { LightningElement, api, wire, track } from 'lwc';

import filteredOppList from '@salesforce/apex/AuditForecastController.AuditForecastHandler';
import setExpectedRevenueLogic from '@salesforce/apex/AuditForecastController.setExpectedRevenueLogic';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class AuditForecastController extends LightningElement {
@api recordId; // Captures current record ID context page natively

@wire(filteredOppList)
    wiredOppsResult;
    get opportunityList() {
    return this.wiredOppsResult?.data || [
        {Name: '' , Amount: '', Probability: '', Expected_Revenue_Overridden: ''}
    ];
}

@wire(setExpectedRevenueLogic)
    wiredExpectedReveneu;
    get expectedRevenueList() {
    return this.expectedRevenueList?.data || [];
}

async handleProcessRevenue(event) {
const recordId = event.target.dataset.id;
// 2. Wrap all imperative execution promises inside an error catch block
try {
// 3. Pause runtime execution using await to block until database returns
await setExpectedRevenueLogic({ oppId: recordId });
}
catch (error) {
console.error('Database process failed:', error.body.message);
}
}

}