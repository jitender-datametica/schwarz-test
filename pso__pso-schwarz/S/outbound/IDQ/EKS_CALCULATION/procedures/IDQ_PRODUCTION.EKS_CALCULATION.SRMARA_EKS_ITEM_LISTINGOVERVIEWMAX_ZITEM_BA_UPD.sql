CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_listingoverviewmax_zitem_ba_upd()
BEGIN
UPDATE eks_calculation.steks_listingoverviewmax SET
    zarticletype = SR.zarticletypenew,
    zitem_ba = SR.zitem_banew FROM eks_calculation.srmara_eks_item_listingoverviewmax_zitem_ba_updsel AS SR
WHERE steks_listingoverviewmax.listingoverviewid = SR.listingoverviewid AND steks_listingoverviewmax.receivingcountry = SR.receivingcountry AND steks_listingoverviewmax.itemid = SR.itemid AND steks_listingoverviewmax.casesize = SR.casesize;
END;




