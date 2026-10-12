CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_sk_updsel (itemid, itemno,
bitflag, zisskhasba, expr1, itemnoba, `article type`, zitem_ba, zitem_banew) AS SELECT STMARA_EKS_ITEM.itemid,
 STMARA_EKS_ITEM.itemno,
 STMARA_EKS_ITEM.bitflag,
 STMARA_EKS_ITEM.zisskhasba,
 STMARA_EKS_ITEM_1.itemid AS expr1,
 STMARA_EKS_ITEM_1.itemid AS itemnoba,
 STMARA_EKS_ITEM_1.bitflag AS `article type`,
 STMARA_EKS_ITEM.zitem_ba,
 STMARA_EKS_ITEM_1.itemid AS zitem_banew
FROM idq_production_eks_calculation.stmara_eks_item AS STMARA_EKS_ITEM
 INNER JOIN idq_production_eks.itemsorting ON STMARA_EKS_ITEM.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS STMARA_EKS_ITEM_1 ON itemsorting.sortitemid =
  STMARA_EKS_ITEM_1.itemid
WHERE STMARA_EKS_ITEM.bitflag = 4
 AND STMARA_EKS_ITEM_1.bitflag = 2
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(STMARA_EKS_ITEM.itemid AS STRING) ORDER BY zitem_banew IS NULL,
      zitem_banew)) = 1;