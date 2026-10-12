CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_ins()
BEGIN
INSERT INTO idq_production_eks_calculation.steks_listingoverviewmax (listingoverviewid, location, supplierno, cr_locationid, receivingcountry, itemid, casesize, zactive)
(SELECT CAST(listingoverviewid AS INTEGER) AS listingoverviewid, location, CAST(supplierno AS INTEGER) AS supplierno, CAST(cr_locationid AS INTEGER) AS cr_locationid, receivingcountry, CAST(itemid AS INTEGER) AS itemid, casesize, zactive
    FROM idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_inssel);
END;
