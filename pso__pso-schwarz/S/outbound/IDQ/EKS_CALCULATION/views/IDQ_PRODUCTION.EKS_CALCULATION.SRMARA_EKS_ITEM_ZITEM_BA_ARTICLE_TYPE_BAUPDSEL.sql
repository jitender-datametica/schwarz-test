CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_baupdsel (itemid, zitem_ba,
zitem_banew) AS SELECT DISTINCT itemid,
 zitem_ba,
 itemid AS zitem_banew
FROM idq_production_eks_calculation.stmara_eks_item
WHERE zitem_ba IS NULL
 AND bitflag = 2;