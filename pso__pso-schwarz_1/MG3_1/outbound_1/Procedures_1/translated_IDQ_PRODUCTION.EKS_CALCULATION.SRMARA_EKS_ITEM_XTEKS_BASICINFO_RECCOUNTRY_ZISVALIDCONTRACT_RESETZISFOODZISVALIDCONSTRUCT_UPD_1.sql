CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_resetzisfoodzisvalidconstruct_upd()
BEGIN
UPDATE idq_production_eks_calculation.xteks_basicinfo_reccountry_1 AS xt SET
    zisvalidcontract = sr.zisvalidcontractnew FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_resetzisfoodzisvalidconstruct_updsel_1 AS sr
WHERE xt.listingoverviewid = sr.listingoverviewid AND xt.itemid = sr.itemid AND xt.casesize = sr.casesize AND xt.supplierno = sr.supplierno AND xt.itemno = sr.itemno AND xt.sk_itemid = sr.sk_itemid AND xt.sk_itemno = sr.sk_itemno AND xt.receivingcountry = sr.receivingcountry;
END;
