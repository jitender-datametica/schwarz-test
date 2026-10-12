CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_multiple_ea_for_kolligtin_sel_1 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
kolligtin, eas, zrelevantmdm, zsource, zactive, znegotiatingcountry) AS SELECT stmara_eks_item.znegotiatingcountry AS
 negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 itg.gtin AS kolligtin,
  (SELECT STRING_AGG(CONCAT(a.znegotiatingcountry, '-', CAST(a.itemno AS STRING)), ', ' ORDER BY a.znegotiatingcountry
     IS NULL, a.znegotiatingcountry, a.itemno IS NULL, a.itemno) AS ea_s
  FROM idq_production_eks_calculation.stmara_eks_item_1 AS a
   INNER JOIN idq_production_eks.item_1 AS it0 ON a.itemid = it0.itemid AND it0.brandtypeid = 1
   INNER JOIN idq_production_eks.itemgtin_1 AS gtin ON FALSE) AS eas,
  CASE
  WHEN stmara_eks_item.ziscurrentcontractfromsk = 1 AND stmara_eks_item.ziscurrentcontract = 0
  THEN SK.zrelevantmdm
  ELSE CAST(stmara_eks_item.zrelevantmdm AS STRING)
  END AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive,
 stmara_eks_item.znegotiatingcountry
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.item_1 AS it ON stmara_eks_item.itemid = it.itemid AND it.brandtypeid = 1
 INNER JOIN idq_production_eks.itemgtin_1 AS itg ON stmara_eks_item.itemid = itg.itemid
 LEFT JOIN (SELECT xteks_basicinfo_reccountry.itemid,
   MIN(CAST(stmara_eks_item0.zrelevantmdm AS STRING)) AS zrelevantmdm
  FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item0 ON xteks_basicinfo_reccountry.sk_itemid
     = stmara_eks_item0.itemid
  GROUP BY xteks_basicinfo_reccountry.itemid) AS SK ON stmara_eks_item.itemid = SK.itemid
WHERE stmara_eks_item.zarticletype = 'EA'
 AND (stmara_eks_item.zactive = 1 OR stmara_eks_item.ziscurrentcontract = 1 OR stmara_eks_item.ziscurrentcontractfromsk
    = 1)
 AND itg.gtin IN (SELECT itg1.gtin
   FROM idq_production_eks.itemgtin_1 AS itg1
    INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS it1 ON itg1.itemid = it1.itemid AND itg1.no_gtin = 0
     AND (it1.zactive = 1 OR it1.ziscurrentcontract = 1 OR it1.ziscurrentcontractfromsk = 1)
    INNER JOIN idq_production_eks.item_1 AS it2 ON it1.itemid = it2.itemid AND it2.brandtypeid = 1
   GROUP BY itg1.gtin
   HAVING COUNT(DISTINCT it1.itemno) > 1);