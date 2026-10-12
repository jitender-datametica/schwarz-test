CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_ins()
BEGIN
INSERT INTO idq_production_eks_calculation.steks_listingoverviewmax_2 (listingoverviewid, location_2, supplierno, cr_locationid, receivingcountry, itemid, casesize, zactive)
(SELECT CAST(listingoverviewid AS INTEGER) AS listingoverviewid, location_2, CAST(supplierno AS INTEGER) AS supplierno, CAST(cr_locationid AS INTEGER) AS cr_locationid, receivingcountry, CAST(itemid AS INTEGER) AS itemid, casesize, zactive
    FROM idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_inssel_2);
END;
