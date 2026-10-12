CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_sk_upd()
BEGIN
UPDATE idq_production_eks_calculation.steks_listingoverviewmax_2 SET
    zactive = sr.zactivenew FROM idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_sk_updsel_2 AS sr
WHERE steks_listingoverviewmax.listingoverviewid = sr.listingoverviewid AND steks_listingoverviewmax.receivingcountry = sr.receivingcountry AND steks_listingoverviewmax.itemid = sr.itemid;
END;
