CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_sk_upd()
BEGIN
UPDATE eks_calculation.xteks_basicinfo_reccountry_1 SET
    zisvalidcontract = SR.zisvalidcontractnew FROM eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_sk_updsel_1 AS SR
WHERE xteks_basicinfo_reccountry.listingoverviewid = SR.listingoverviewid AND xteks_basicinfo_reccountry.casesize = SR.casesize AND xteks_basicinfo_reccountry.sk_itemid = SR.sk_itemid AND xteks_basicinfo_reccountry.itemid = SR.itemid AND xteks_basicinfo_reccountry.contractpricevalidityid = SR.contractpricevalidityid AND xteks_basicinfo_reccountry.supplierno = SR.supplierno;
END;




