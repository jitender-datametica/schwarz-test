CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_listingoverviewmax_location_upd()
BEGIN
UPDATE eks_calculation.steks_listingoverviewmax_1 SET
    cr_locationid = SR.cr_locationidnew,
    location_1 = SR.locationnew FROM eks_calculation.srmara_eks_item_listingoverviewmax_location_updsel_1 AS SR
WHERE steks_listingoverviewmax.listingoverviewid = SR.listingoverviewid AND steks_listingoverviewmax.receivingcountry = SR.receivingcountry AND steks_listingoverviewmax.itemid = SR.itemid AND steks_listingoverviewmax.casesize = SR.casesize;
END;




