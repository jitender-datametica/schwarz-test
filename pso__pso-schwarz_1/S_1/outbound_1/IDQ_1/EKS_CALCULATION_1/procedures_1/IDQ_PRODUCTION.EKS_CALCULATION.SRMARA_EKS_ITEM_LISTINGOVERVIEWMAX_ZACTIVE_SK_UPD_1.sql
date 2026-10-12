CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_listingoverviewmax_zactive_sk_upd()
BEGIN
UPDATE eks_calculation.steks_listingoverviewmax_1 SET
    zactive = SR.zactivenew FROM eks_calculation.srmara_eks_item_listingoverviewmax_zactive_sk_updsel_1 AS SR
WHERE steks_listingoverviewmax.listingoverviewid = SR.listingoverviewid AND steks_listingoverviewmax.receivingcountry = SR.receivingcountry AND steks_listingoverviewmax.itemid = SR.itemid;
END;




