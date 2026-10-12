CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_01_updsel_2 (itemid, itemno
, bitflag, ziseahasba, expr1, expr2, zitem_ba, zitem_banew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.bitflag,
 stmara_eks_item.ziseahasba,
 stmara_eks_item_1.itemid AS expr1,
 stmara_eks_item_1.bitflag AS expr2,
 stmara_eks_item.zitem_ba,
 stmara_eks_item_1.itemid AS zitem_banew
FROM idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item_2
 INNER JOIN idq_production_eks.itemsorting_2 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item_1 ON itemsorting.sortitemid =
  stmara_eks_item_1.itemid
WHERE stmara_eks_item.bitflag = 0
 AND stmara_eks_item.ziseahasba = 1
 AND stmara_eks_item_1.bitflag = 2
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(stmara_eks_item.itemid AS STRING) ORDER BY zitem_banew IS NULL,
      zitem_banew)) = 1;