CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderowduplicates_updsel (uid
, itemid, itemno, zhiderow, zhiderownew) AS SELECT stmara_eks_item_relevancychecksdetail.uid,
 stmara_eks_item_relevancychecksdetail.itemid,
 stmara_eks_item_relevancychecksdetail.itemno,
 stmara_eks_item_relevancychecksdetail.zhiderow,
 1 AS zhiderownew
FROM idq_production_eks_calculation.stmara_eks_item_relevancychecksdetail
 INNER JOIN (SELECT itemid,
   itemno,
   sk_itemno,
   MIN(uid) AS min_uid
  FROM idq_production_eks_calculation.stmara_eks_item_relevancychecksdetail AS stmara_eks_item_relevancychecksdetail_1
  GROUP BY itemid,
   itemno,
   sk_itemno) AS Min_UID ON stmara_eks_item_relevancychecksdetail.itemid = Min_UID.itemid AND
    stmara_eks_item_relevancychecksdetail.sk_itemno = Min_UID.sk_itemno AND stmara_eks_item_relevancychecksdetail.uid <>
   Min_UID.min_uid
WHERE stmara_eks_item_relevancychecksdetail.zactive = 1
 AND stmara_eks_item_relevancychecksdetail.ziscurrentcontractfromsk = 1
 AND stmara_eks_item_relevancychecksdetail.ziscurrentcontract IS NULL
 AND stmara_eks_item_relevancychecksdetail.zarticletype = 'EA';