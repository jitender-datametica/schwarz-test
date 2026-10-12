CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractupdsel_2 (itemid,
ziscurrentcontract, ziscurrentcontractnew) AS SELECT itemid,
 ziscurrentcontract,
 '1' AS ziscurrentcontractnew
FROM idq_production_eks_calculation.stmara_eks_item_2
WHERE ziscurrentcontract IS NULL
 AND IFNULL(zhasvalidmaxlu, 0) = 1
 AND IFNULL(zhasvalidadsflg, 0) = 1
 AND IFNULL(zhasvalidcontractdate, 0) = 1;