CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_ins()
BEGIN
INSERT INTO eks_calculation.steks_listingoverviewmax (listingoverviewid, location, supplierno, cr_locationid, receivingcountry, itemid, casesize, zactive)
(SELECT *
    FROM eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_inssel);
END;




