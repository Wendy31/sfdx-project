({
    doInit: function (component, event, helper) {
        // contruct columns 
        const columns = [{
                label: 'Game Number',
                fieldName: 'Name',
                type: 'text'
            },
            {
                label: 'Mode',
                fieldName: 'Mode__c',
                type: 'text'
            },
            {
                label: 'Played On',
                fieldName: 'CreatedDate',
                type: 'date'
            }, {
                label: 'Result',
                fieldName: 'Result__c',
                type: 'text'
            }
        ];
        component.set("v.columns", columns);

        // after columns are set, get results and populate datatable
        helper.fetchResult(component);
    },

    onResultHandler: function (component) {
        // make another server side call and fetch latest results from APEX method 
        // datatable will reload with fresh results 
        helper.fetchResult(component);
    }
})