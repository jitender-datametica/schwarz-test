CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_location_upd()
BEGIN
UPDATE idq_production_eks_calculation.steks_listingoverviewmax_1 SET
    cr_locationid = CAST(sr.cr_locationidnew AS INTEGER),
    location_1 = sr.locationnew FROM idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_location_updsel_1 AS sr
WHERE steks_listingoverviewmax.listingoverviewid = sr.listingoverviewid AND steks_listingoverviewmax.receivingcountry = sr.receivingcountry AND steks_listingoverviewmax.itemid = sr.itemid AND steks_listingoverviewmax.casesize = sr.casesize;
END;
