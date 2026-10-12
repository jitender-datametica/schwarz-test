CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_upd()
BEGIN
UPDATE eks_calculation.steks_listingoverviewmax_2 SET
    listingoverviewid = SR.listingoverviewidnew FROM eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_updsel_2 AS SR
WHERE steks_listingoverviewmax.listingoverviewid = SR.listingoverviewid AND steks_listingoverviewmax.receivingcountry = SR.receivingcountry AND steks_listingoverviewmax.itemid = SR.itemid AND steks_listingoverviewmax.casesize = SR.casesize;
END;




