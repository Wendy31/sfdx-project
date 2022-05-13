public with sharing class ProductController {
    // Create new Products: Create MTO yearly subscriptions with ProductCode _1Y
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
        // 2. Script to insert Standard PBE
        // 3. Script to add new PBE for Pricebooks for specific countries.
        // 4. Script to insert MerchantCapability
        // 5. Script to insert ResellerCapability
    }
}
