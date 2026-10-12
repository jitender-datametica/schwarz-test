CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_meins_rollupfromea_01_1 (zitem_ba, zmeins) AS SELECT
 zitem_ba,
 MAX(zmeins) AS zmeins
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE bitflag = 0
GROUP BY zitem_ba;