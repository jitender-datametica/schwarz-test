CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhideskflag_updsel_2 (uid,
itemid, itemno, zhideskflag, zhideskflagnew) AS SELECT uid,
 itemid,
 itemno,
 zhideskflag,
 1 AS zhideskflagnew
FROM idq_production_eks_calculation.stmara_eks_item_relevancychecksdetail_2
WHERE zarticletype <> 'EA'
 OR ziscurrentcontract <> 0;