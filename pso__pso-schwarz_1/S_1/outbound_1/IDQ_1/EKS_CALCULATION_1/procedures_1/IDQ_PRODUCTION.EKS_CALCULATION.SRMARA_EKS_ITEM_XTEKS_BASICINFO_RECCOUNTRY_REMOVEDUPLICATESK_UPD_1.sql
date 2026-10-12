CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_upd()
BEGIN
UPDATE eks_calculation.xteks_basicinfo_reccountry_1 SET
    zisvalidcontract = SR.zisvalidcontractnew FROM eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_updsel_1 AS SR
WHERE xteks_basicinfo_reccountry.listingoverviewid = SR.listingoverviewid AND xteks_basicinfo_reccountry.itemid = SR.itemid AND xteks_basicinfo_reccountry.receivingcountry = SR.receivingcountry AND xteks_basicinfo_reccountry.casesize = SR.casesize;
END;




