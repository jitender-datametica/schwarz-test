CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_listingoverviewmax_ins()
BEGIN
INSERT INTO eks_calculation.steks_listingoverviewmax_2 (listingoverviewid, location_2, supplierno, cr_locationid, receivingcountry, itemid, casesize)
(SELECT listingoverviewid, location_2, supplierno, CAST(ROUND(CAST(IF(cr_locationid = '', NULL, cr_locationid) AS BIGNUMERIC),0) AS INT64) AS cr_locationid, receivingcountry, itemid, casesize
    FROM eks_calculation.stmara_eks_item_listingoverviewmax_inssel_2);
END;

