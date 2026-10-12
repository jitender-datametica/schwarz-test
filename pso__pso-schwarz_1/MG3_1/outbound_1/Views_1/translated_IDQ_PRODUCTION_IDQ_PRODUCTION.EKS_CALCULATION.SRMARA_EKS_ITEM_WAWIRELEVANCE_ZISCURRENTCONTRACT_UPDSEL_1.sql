CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontract_updsel_1 (itemid,
ziscurrentcontract, ziscurrentcontractnew) AS SELECT DISTINCT itemid,
 ziscurrentcontract,
 1 AS ziscurrentcontractnew
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE bitflag = 0
 AND ziscurrentcontract IS NULL
 AND zrelevantmdm = 1;