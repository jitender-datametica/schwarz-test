CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_ins()
BEGIN
INSERT INTO idq_production_eks_calculation.steks_listingoverviewmax_1 (listingoverviewid, location_1, supplierno, cr_locationid, receivingcountry, itemid, casesize)
(SELECT listingoverviewid, location_1, supplierno, CAST(IF(cr_locationid = '', NULL, cr_locationid) AS INTEGER) AS cr_locationid, receivingcountry, itemid, casesize
    FROM idq_production_eks_calculation.stmara_eks_item_listingoverviewmax_inssel_1);
END;
