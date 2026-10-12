CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_02_updsel_2 (itemid, itemno
, ziseahasskhasba, zarticletype, zitem_ba, zitem_banew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.ziseahasskhasba,
 stmara_eks_item.zarticletype,
 stmara_eks_item.zitem_ba,
 MAX(stmara_eks_item_2.itemid) AS zitem_banew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemsorting_2 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item_1 ON itemsorting.sortitemid =
  stmara_eks_item_1.itemid
 INNER JOIN idq_production_eks.itemsorting_2 AS steks_itemsorting_1 ON stmara_eks_item_1.itemid = steks_itemsorting_1.itemid
  
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item_2 ON steks_itemsorting_1.sortitemid =
  stmara_eks_item_2.itemid
WHERE stmara_eks_item.bitflag = 0
 AND stmara_eks_item_1.bitflag = 4
 AND stmara_eks_item_2.bitflag = 2
 AND stmara_eks_item.ziseahasskhasba = 1
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.ziseahasskhasba,
 stmara_eks_item.zarticletype,
 stmara_eks_item.zitem_ba;