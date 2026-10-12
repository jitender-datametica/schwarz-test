CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_easinactivebuyer_sel_all_2 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description_int,
zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int,
  CASE
  WHEN stmara_eks_item.ziscurrentcontractfromsk = 1 AND stmara_eks_item.ziscurrentcontract = 0
  THEN SK.zrelevantmdm
  ELSE stmara_eks_item.zrelevantmdm
  END AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item_2
 LEFT JOIN (SELECT xteks_basicinfo_reccountry.itemid,
   MIN(stmara_eks_item0.zrelevantmdm) AS zrelevantmdm
  FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_2
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item0 ON xteks_basicinfo_reccountry.sk_itemid
     = stmara_eks_item0.itemid
  GROUP BY xteks_basicinfo_reccountry.itemid) AS SK ON stmara_eks_item.itemid = SK.itemid
WHERE UPPER(stmara_eks_item.buyershortsign) LIKE '%X'
 AND stmara_eks_item.zarticletype = 'EA'
 AND stmara_eks_item.zactive = 1;