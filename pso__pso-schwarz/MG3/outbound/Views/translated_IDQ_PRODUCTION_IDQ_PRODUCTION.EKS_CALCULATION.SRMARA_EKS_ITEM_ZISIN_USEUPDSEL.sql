CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zisin_useupdsel (itemid, zisin_use, zisin_usenew)
AS SELECT DISTINCT itemid,
 zisin_use,
 in_use AS zisin_usenew
FROM idq_production_eks_calculation.stmara_eks_item
WHERE zisin_use IS NULL;