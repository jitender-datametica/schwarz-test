CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_02_updsel_2 (itemid, itemno
, ziseahasskhasba, zarticletype, zitem_ba, zitem_banew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.ziseahasskhasba,
 stmara_eks_item.zarticletype,
 stmara_eks_item.zitem_ba,
 MAX(STMARA_EKS_ITEM_2.itemid) AS zitem_banew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemsorting_2 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS STMARA_EKS_ITEM_1 ON itemsorting.sortitemid =
  STMARA_EKS_ITEM_1.itemid
 INNER JOIN idq_production_eks.itemsorting_2 AS STEKS_ITEMSORTING_1 ON STMARA_EKS_ITEM_1.itemid = STEKS_ITEMSORTING_1.itemid
  
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS STMARA_EKS_ITEM_2 ON STEKS_ITEMSORTING_1.sortitemid =
  STMARA_EKS_ITEM_2.itemid
WHERE stmara_eks_item.bitflag = 0
 AND STMARA_EKS_ITEM_1.bitflag = 4
 AND STMARA_EKS_ITEM_2.bitflag = 2
 AND stmara_eks_item.ziseahasskhasba = 1
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.ziseahasskhasba,
 stmara_eks_item.zarticletype,
 stmara_eks_item.zitem_ba;