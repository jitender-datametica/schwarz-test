CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_matklupdsel (itemid, zmatkl, zmatklnew) AS SELECT
 itemid,
 zmatkl,
 zlegacymatkl AS zmatklnew
FROM idq_production_eks_calculation.stmara_eks_item
WHERE zmatkl IS NULL;