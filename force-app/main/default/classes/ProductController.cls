public with sharing class ProductController {
    // Create new Products: Create MTO yearly subscriptions with ProductCode _1Y
    // https://horecadigital.atlassian.net/browse/SFDC-9733
    /*
    Create copies of the following products:

MTO_MTOProfessional

MTO_MTOProfessionalSetup

MTO_MTOProfOrder

MTO_MTOProfOrderSetup

MTO_MTOPremium

MTO_MTOPremiumSetup

All field entries shall remain the same with the following changes for each product:

Subscriptions: (MTO_MTOProfessional, MTO_MTOProfOrder, MTO_MTOPremium)

AddProducts__C → relate to the newly created setup product for the same subscription (productcode)

DefaultPeriod = Yearly

ProductCode = the respective one of these:

MTO_MTOProfessional → MTO_MTOProfessional_1Y

MTO_MTOProfessionalSetup → MTO_MTOProfessionalSetup_1Y

MTO_MTOProfOrder → MTO_MTOProfOrder_1Y

MTO_MTOProfOrderSetup → MTO_MTOProfOrderSetup_1Y

MTO_MTOPremium → MTO_MTOPremium_1Y

MTO_MTOPremiumSetup → MTO_MTOPremiumSetup_1Y

Name → concatenate “ (1 Year)” to the end of the present name (e.g. “Professional Order (1 Year)”)

 

For 

the created products above 

as well as the 4 products and their setup products already in the system today (MTO_MTOStarter, MTO_MTOProfessional, MTO_MTOProfOrder, MTO_MTOPremium and their setup counterparts), in the field ExcludeAddProducts__c , next to the product written there today, add the newly created counterpart (e.g. on MTO_MTOProfessional, this field carries “MTO_MTOPremium” → we now add the product code for the yearly Product for MTO_MTOPremium next to this) → this will lead to the activation fee not being added again on Up- and Downgrades and shall work regardless if yearly or monthly. This is why it also needs to be added to the monthly MTO Starter.

Create Pricebookentries for (prices are no longer needed)

Spain → copy the HD and MCCES agency and merchant and reseller capabilities for the new products

Germany → copy the HD and MCCDE agency and merchant and reseller capabilities for the new products

France → copy the HD and MCCFR agency and merchant and reseller capabilities for the new products

Italy → copy the HD and MCCIT agency and merchant and reseller capabilities for the new products

Poland → copy the HD and MCCPL agency and merchant and reseller capabilities for the new products

Hungary → copy the HD and MCCHU agency and merchant and reseller capabilities for the new products

Romania → copy the HD and MCCRO agency and merchant and reseller capabilities for the new products

Changes on Pricebooks:

ChargeOnOrder = True for all created Pricebooks

Product Name Invoice: Add “ (12 Months) to the end of it

ES

DE

FR

IT

PL

HU

RO

Create respective entries for Merchantcapabilities and Resellercapabilities for these countries, for these products, for Merchants (see above). Update the current settings documentation: Merchants and MerchantCapability  and Reseller and ResellerCapability (Sales Agencies) 

Bring to all lower envs by deployment. Bring to Prod only on final release around May31st

    */
    public ProductController() {
        // 1. Script to create products
        /*List<String> productCodes = new List<String>{
            'MTO_MTOProfessional','MTO_MTOProfessionalSetup', 'MTO_MTOProfOrder','MTO_MTOProfOrderSetup', 'MTO_MTOPremium', 'MTO_MTOPremiumSetup'
        };
        
        List<Product2> productsToInsert = new List<Product2>();
        
        List<Product2> productsToClone = [
                SELECT Id, Name, ProductCode, ExcludeAddProducts__c, AddProducts__c, Available_on_Order__c, BillingType__c, Contact_for_Second_Level_Support__c, CurrencyIsoCode, DefaultPeriod__c, Downgradeable__c, External_Product_ID__c, External_URL__c, Family, Full_Description_DE__c, Full_Description_EN__c, Full_Description_FR__c, Google_Rating__c, GraceTimeDaysUnpaid__c, Is_Product_Expiring__c, IsBundle__c, IsDISHProduct__c, IsHDPayProduct__c, IsOdooProduct__c, IsSetupProduct__c, OnboardingFamily__c, OnGraceTime__c, Partner__c, Payment_Frequency__c, PaymentType__c, Product_Domain__c, Product_Owner__c, ProductFamily__c, RecordTypeId, Recurring_Times__c, Sales_Material_URL__c, Short_Description_DE__c, Short_Description_EN__c, Short_Description_FR__c, ShowOnInvoices__c, Startup__c, Technical_Description_DE__c, Technical_Description_EN__c, Technical_Description_FR__c, Tier__c, Tools__c, Total_Nr_of_Customers__c, Unsubscribeable__c  
                FROM Product2 
                WHERE ProductCode IN: productCodes];
        for (Product2 p : productsToClone) {
          Product2 tempProduct = p.clone(false, true, false, false);
          tempProduct.ProductCode = p.ProductCode + '_1Y';
          tempProduct.DefaultPeriod__c = 'Yearly';
          tempProduct.Name = p.Name + ' (1 Year)';
          tempProduct.AddProducts__c = String.isNotBlank(p.AddProducts__c) && p.AddProducts__c.contains('Setup') ? p.AddProducts__c + '_1Y' : '';
          if (String.isNotBlank(p.ExcludeAddProducts__c)) {
            List<String> excludeAddProducts = p.ExcludeAddProducts__c?.split(';');
            List<String> newExcludedProducts = new List<String>();
            for (String ex : excludeAddProducts) {
                if (productCodes.contains(ex)) {
                  newExcludedProducts.add(ex + '_1Y');
                }
            }
            tempProduct.ExcludeAddProducts__c = newExcludedProducts.isEmpty() ? 
                    p.ExcludeAddProducts__c :  
                    p.ExcludeAddProducts__c + ';' + String.join(newExcludedProducts, ';');
            
            p.ExcludeAddProducts__c = tempProduct.ExcludeAddProducts__c;
            productsToInsert.add(p);
          }
          
          productsToInsert.add(tempProduct);
        }
        
        upsert productsToInsert;
        */

        // 2. Script to insert Standard PBE
        /*
        Map<String, Product2> newProductByCode = new Map<String, Product2>();

List<String> newProductCodes = new List<String>{
        'MTO_MTOProfessional_1Y','MTO_MTOProfessionalSetup_1Y',
        'MTO_MTOProfOrder_1Y','MTO_MTOProfOrderSetup_1Y', 'MTO_MTOPremium_1Y',
        'MTO_MTOPremiumSetup_1Y'};

List<Product2> newProducts = [SELECT Id, ProductCode FROM Product2 WHERE ProductCode IN: newProductCodes];
for (Product2 p : newProducts) {
    newProductByCode.put(p.ProductCode, p);
}

List<String> productCodes = new List<String>{
        'MTO_MTOProfessional','MTO_MTOProfessionalSetup', 'MTO_MTOProfOrder',
        'MTO_MTOProfOrderSetup', 'MTO_MTOPremium', 'MTO_MTOPremiumSetup'};

List<PricebookEntry> pbEntries = [
        SELECT Id, Pricebook2Id, Product2Id, ProductCode, UnitPrice, 
          VATPercent__c, ActivateWithoutPayment__c, ChargeOnOrder__c, 
          Not_For_Call_Center__c, Payment_Methods__c, PaymentSchedule__c, 
          RecurringPaymentEnabled__c, TransactionType__c, Product_Name_Invoice__c, 
          ProductType__c, IsActive, CurrencyIsoCode, DowngradeWithoutPayment__c, 
          EndOfTrialPeriod__c 
        FROM PricebookEntry 
        WHERE ProductCode IN : productCodes AND Pricebook2.IsStandard = TRUE];

List<PricebookEntry> newPBEntries = new List<PricebookEntry>();
for (PricebookEntry pbe : pbEntries) {
    if (productCodes.contains(pbe.ProductCode)) {
        PricebookEntry tempPBE = new PricebookEntry();
        tempPBE.Pricebook2Id = pbe.Pricebook2Id;
        tempPBE.Product2Id = newProductByCode.get(pbe.ProductCode + '_1Y').Id;
        tempPBE.UnitPrice = 0;
        tempPBE.VATPercent__c = 21;
        tempPBE.ActivateWithoutPayment__c = pbe.ActivateWithoutPayment__c;
        tempPBE.ChargeOnOrder__c = true;
        tempPBE.Not_For_Call_Center__c = pbe.Not_For_Call_Center__c;
        tempPBE.Payment_Methods__c = pbe.Payment_Methods__c;
        tempPBE.PaymentSchedule__c = pbe.PaymentSchedule__c;
        tempPBE.RecurringPaymentEnabled__c = pbe.RecurringPaymentEnabled__c;
        tempPBE.TransactionType__c = pbe.TransactionType__c;
        tempPBE.Product_Name_Invoice__c = String.isNotBlank(pbe.Product_Name_Invoice__c) ? pbe.Product_Name_Invoice__c + ' (12 Months)' : '';
        tempPBE.ProductType__c = pbe.ProductType__c;
        tempPBE.IsActive = true;
        tempPBE.CurrencyIsoCode = pbe.CurrencyIsoCode;
        
        newPBEntries.add(tempPBE);
    }
}
insert newPBEntries;
        */

        // 3. Script to add new PBE for Pricebooks for specific countries
        /*
        Map<String, Product2> newProductByCode = new Map<String, Product2>();

List<String> newProductCodes = new List<String>{
        'MTO_MTOProfessional_1Y','MTO_MTOProfessionalSetup_1Y',
        'MTO_MTOProfOrder_1Y','MTO_MTOProfOrderSetup_1Y', 'MTO_MTOPremium_1Y',
        'MTO_MTOPremiumSetup_1Y'};

List<Product2> newProducts = [SELECT Id, ProductCode FROM Product2 WHERE ProductCode IN: newProductCodes];
for (Product2 p : newProducts) {
    newProductByCode.put(p.ProductCode, p);
}

List<String> countryCodes = new List<String>{
        'ES', 'DE', 'FR', 'IT', 'PL', 'HU', 'RO'
};

List<String> productCodes = new List<String>{
        'MTO_MTOProfessional','MTO_MTOProfessionalSetup', 'MTO_MTOProfOrder',
        'MTO_MTOProfOrderSetup', 'MTO_MTOPremium', 'MTO_MTOPremiumSetup'};

List<PricebookEntry> pbEntries = [
        SELECT Id, Pricebook2Id, Product2Id, ProductCode, UnitPrice, 
          VATPercent__c, ActivateWithoutPayment__c, ChargeOnOrder__c, 
          Not_For_Call_Center__c, Payment_Methods__c, PaymentSchedule__c, 
          RecurringPaymentEnabled__c, TransactionType__c, Product_Name_Invoice__c, 
          ProductType__c, IsActive, CurrencyIsoCode, DowngradeWithoutPayment__c, 
          EndOfTrialPeriod__c 
        FROM PricebookEntry 
        WHERE ProductCode IN : productCodes AND Pricebook2.Country__r.Country_Code__c IN : countryCodes];

List<PricebookEntry> newPBEntries = new List<PricebookEntry>();
for (PricebookEntry pbe : pbEntries) {
    if (productCodes.contains(pbe.ProductCode)) {
        PricebookEntry tempPBE = new PricebookEntry();
        tempPBE.Pricebook2Id = pbe.Pricebook2Id;
        tempPBE.Product2Id = newProductByCode.get(pbe.ProductCode + '_1Y').Id;
        tempPBE.UnitPrice = pbe.UnitPrice;
        tempPBE.VATPercent__c = pbe.VATPercent__c;
        tempPBE.ActivateWithoutPayment__c = pbe.ActivateWithoutPayment__c;
        tempPBE.ChargeOnOrder__c = true;
        tempPBE.Not_For_Call_Center__c = pbe.Not_For_Call_Center__c;
        tempPBE.Payment_Methods__c = pbe.Payment_Methods__c;
        tempPBE.PaymentSchedule__c = pbe.PaymentSchedule__c;
        tempPBE.RecurringPaymentEnabled__c = pbe.RecurringPaymentEnabled__c;
        tempPBE.TransactionType__c = pbe.TransactionType__c;
        tempPBE.Product_Name_Invoice__c = String.isNotBlank(pbe.Product_Name_Invoice__c) ? pbe.Product_Name_Invoice__c + ' (12 Months)' : '';
        tempPBE.ProductType__c = pbe.ProductType__c;
        tempPBE.IsActive = true;
        tempPBE.CurrencyIsoCode = pbe.CurrencyIsoCode;
        
        newPBEntries.add(tempPBE);
    }
}
insert newPBEntries;

        */

        // 4. Script to insert MerchantCapability
        /*
        Map<String, Product2> newProductByCode = new Map<String, Product2>();

List<String> newProductCodes = new List<String>{
        'MTO_MTOProfessional_1Y','MTO_MTOProfessionalSetup_1Y',
        'MTO_MTOProfOrder_1Y','MTO_MTOProfOrderSetup_1Y', 'MTO_MTOPremium_1Y',
        'MTO_MTOPremiumSetup_1Y'};

List<Product2> newProducts = [SELECT Id, ProductCode FROM Product2 WHERE ProductCode IN: newProductCodes];
for (Product2 p : newProducts) {
    newProductByCode.put(p.ProductCode, p);
}

List<String> countryCodes = new List<String>{
        'ES', 'DE', 'FR', 'IT', 'PL', 'HU', 'RO'
};

List<String> resellerMerchantNames = new List<String>{
        'HD', 'MCCES', 'MCCDE', 'MCCFR', 'MCCIT', 'MCCPL', 'MCCHU', 'MCCRO'
};

List<String> productCodes = new List<String>{
        'MTO_MTOProfessional','MTO_MTOProfessionalSetup', 'MTO_MTOProfOrder',
        'MTO_MTOProfOrderSetup', 'MTO_MTOPremium', 'MTO_MTOPremiumSetup'};


List<MerchantCapability__c> mcList = [SELECT Country__c, Product__r.ProductCode, OneTimeChargeDeferral__c, SkipPayment__c, Country__r.Name, ResellerMerchant__c, ResellerMerchant__r.Name, TrialMonths__c, TrialMonthsCharge__c FROM MerchantCapability__c WHERE Country__r.Country_Code__c IN : countryCodes AND Product__r.ProductCode IN : productCodes AND ResellerMerchant__r.Name IN : resellerMerchantNames];

List<MerchantCapability__c> mcToInsert = new List<MerchantCapability__c>();
for (MerchantCapability__c mc : mcList) {
    MerchantCapability__c tempMC = new MerchantCapability__c();
    tempMC.ResellerMerchant__c = mc.ResellerMerchant__c;
    tempMC.Country__c = mc.Country__c;
    tempMC.TrialMonths__c = mc.TrialMonths__c;
    tempMC.TrialMonthsCharge__c = mc.TrialMonthsCharge__c;
    tempMC.OneTimeChargeDeferral__c = mc.OneTimeChargeDeferral__c;
    tempMC.Product__c = newProductByCode.get(mc.Product__r.ProductCode + '_1Y').Id;
    tempMC.Name = mc.ResellerMerchant__r.Name + ' ' + mc.Country__r.Name + ' ' + mc.Product__r.ProductCode + '_1Y';

    mcToInsert.add(tempMC);
}
insert mcToInsert;

        */

        // 5. Script to insert ResellerCapability

        /*
        Map<String, Product2> newProductByCode = new Map<String, Product2>();

List<String> newProductCodes = new List<String>{
        'MTO_MTOProfessional_1Y','MTO_MTOProfessionalSetup_1Y',
        'MTO_MTOProfOrder_1Y','MTO_MTOProfOrderSetup_1Y', 'MTO_MTOPremium_1Y',
        'MTO_MTOPremiumSetup_1Y'};

List<Product2> newProducts = [SELECT Id, ProductCode FROM Product2 WHERE ProductCode IN: newProductCodes];
for (Product2 p : newProducts) {
    newProductByCode.put(p.ProductCode, p);
}

List<String> countryCodes = new List<String>{
        'ES', 'DE', 'FR', 'IT', 'PL', 'HU', 'RO'
};

List<String> resellerMerchantNames = new List<String>{
        'HD', 'MCCES', 'MCCDE', 'MCCFR', 'MCCIT', 'MCCPL', 'MCCHU', 'MCCRO'
};

List<String> productCodes = new List<String>{
        'MTO_MTOProfessional','MTO_MTOProfessionalSetup', 'MTO_MTOProfOrder',
        'MTO_MTOProfOrderSetup', 'MTO_MTOPremium', 'MTO_MTOPremiumSetup'};


List<ResellerCapability__c> rcList = [SELECT Reseller__c, Reseller__r.Name, Product__c, Project__c, Country__r.Name, Reseller_Merchant__c, Product__r.ProductCode, Reseller_Merchant__r.Name, VATMandatory__c, METROIDMandatory__c FROM ResellerCapability__c WHERE Country__r.Country_Code__c IN : countryCodes AND Product__r.ProductCode IN : productCodes AND Reseller__r.Name IN : resellerMerchantNames];

List<ResellerCapability__c> rcToInsert = new List<ResellerCapability__c>();
for (ResellerCapability__c rc : rcList) {
    ResellerCapability__c tempRC = rc.clone(false, true);
    tempRC.Product__c = newProductByCode.get(rc.Product__r.ProductCode + '_1Y').Id;
    tempRC.Name = rc.Reseller__r.Name + ' ' + rc.Country__r.Name + ' ' + rc.Product__r.ProductCode + '_1Y';
    
    rcToInsert.add(tempRC);
}
insert rcToInsert;

         */
    }
}
