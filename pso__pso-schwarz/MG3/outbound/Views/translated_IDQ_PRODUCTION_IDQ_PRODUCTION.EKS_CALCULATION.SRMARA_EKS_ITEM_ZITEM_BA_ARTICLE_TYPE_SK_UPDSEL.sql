CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_sk_updsel (itemid, itemno,
bitflag, zisskhasba, expr1, itemnoba, `ARTICLE TYPE`, zitem_ba, zitem_banew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.bitflag,
 stmara_eks_item.zisskhasba,
 stmara_eks_item_1.itemid AS expr1,
 stmara_eks_item_1.itemid AS itemnoba,
 stmara_eks_item_1.bitflag AS `Article type`,
 stmara_eks_item.zitem_ba,
 stmara_eks_item_1.itemid AS zitem_banew
FROM idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item
 INNER JOIN idq_production_eks.itemsorting ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item_1 ON itemsorting.sortitemid =
  stmara_eks_item_1.itemid
WHERE stmara_eks_item.bitflag = 4
 AND stmara_eks_item_1.bitflag = 2
QUALIFY (ROW_NUMBER() OVER (PARTITION BY stmara_eks_item.itemid ORDER BY zitem_banew IS NULL, zitem_banew)) = 1;