CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_different_buyer_sel_all_1 (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, ba_itemno, itemid, itemno, articletype,
description, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS
 negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 svmara_eks_item_different_buyer_010.ba_itemno,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
  CASE
  WHEN stmara_eks_item.ziscurrentcontract = 1
  THEN stmara_eks_item.zrelevantmdm
  ELSE SK.zrelevantmdm
  END AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.svmara_eks_item_different_buyer_020_1
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_different_buyer_010_1 ON svmara_eks_item_different_buyer_020.struc
   = svmara_eks_item_different_buyer_010.struc
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 ON svmara_eks_item_different_buyer_010.ea_itemno =
  stmara_eks_item.itemno
 LEFT JOIN (SELECT xteks_basicinfo_reccountry.itemid,
   MIN(stmara_eks_item0.zrelevantmdm) AS zrelevantmdm
  FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item0 ON xteks_basicinfo_reccountry.sk_itemid
     = stmara_eks_item0.itemid
  GROUP BY xteks_basicinfo_reccountry.itemid) AS SK ON stmara_eks_item.itemid = SK.itemid
WHERE svmara_eks_item_different_buyer_010.ba_itemno IS NOT NULL
 OR svmara_eks_item_different_buyer_010.sk_itemno IS NOT NULL;