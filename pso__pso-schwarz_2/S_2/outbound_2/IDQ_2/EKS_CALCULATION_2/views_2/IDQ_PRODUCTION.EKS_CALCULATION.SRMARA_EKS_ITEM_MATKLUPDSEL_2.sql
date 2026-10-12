CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_matklupdsel_2 (itemid, zmatkl, zmatklnew) AS SELECT
 itemid,
 zmatkl,
 zlegacymatkl AS zmatklnew
FROM idq_production_eks_calculation.stmara_eks_item_2
WHERE zmatkl IS NULL;