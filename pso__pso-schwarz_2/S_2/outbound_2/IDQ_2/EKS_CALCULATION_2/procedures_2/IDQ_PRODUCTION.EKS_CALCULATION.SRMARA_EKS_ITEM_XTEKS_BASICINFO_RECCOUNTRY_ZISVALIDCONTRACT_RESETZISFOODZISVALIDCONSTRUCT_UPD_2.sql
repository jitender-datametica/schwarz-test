CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_resetzisfoodzisvalidconstruct_upd()
BEGIN
UPDATE eks_calculation.xteks_basicinfo_reccountry_2 AS XT SET
    zisvalidcontract = SR.zisvalidcontractnew FROM eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_resetzisfoodzisvalidconstruct_updsel_2 AS SR
WHERE XT.listingoverviewid = SR.listingoverviewid AND XT.itemid = SR.itemid AND XT.casesize = SR.casesize AND XT.supplierno = SR.supplierno AND XT.itemno = SR.itemno AND XT.sk_itemid = SR.sk_itemid AND XT.sk_itemno = SR.sk_itemno AND XT.receivingcountry = SR.receivingcountry;
END;




