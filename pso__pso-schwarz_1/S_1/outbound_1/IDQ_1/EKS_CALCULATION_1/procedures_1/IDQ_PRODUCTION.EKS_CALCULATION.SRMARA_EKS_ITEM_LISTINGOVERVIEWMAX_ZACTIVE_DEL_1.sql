CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_listingoverviewmax_zactive_del()
BEGIN
DELETE FROM eks_calculation.steks_listingoverviewmax_1
WHERE zactive IS NULL OR zactive = 0;
END;




