CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_matkl_article_type_eaupdsel_1 (itemid, zmatkl,
zmatklnew) AS SELECT itemid,
 zmatkl,
 zlegacymatkl AS zmatklnew
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE zmatkl IS NULL
 AND bitflag = 0;