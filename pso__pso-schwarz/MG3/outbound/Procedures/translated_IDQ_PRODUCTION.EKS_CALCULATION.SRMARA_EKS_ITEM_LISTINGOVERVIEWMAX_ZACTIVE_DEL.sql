CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_del()
BEGIN
DELETE FROM idq_production_eks_calculation.steks_listingoverviewmax
WHERE zactive IS NULL OR zactive = 0;
END;
