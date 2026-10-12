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
 ITG.gtin AS kolligtin,
  (SELECT STRING_AGG(CONCAT(A.znegotiatingcountry, '-', CAST(A.itemno AS STRING)), ', ' ORDER BY A.znegotiatingcountry
     IS NULL, A.znegotiatingcountry, A.itemno IS NULL, A.itemno) AS ea_s
  FROM idq_production_eks_calculation.stmara_eks_item_1 AS A
   INNER JOIN idq_production_eks.item_1 AS IT0 ON A.itemid = IT0.itemid AND IT0.brandtypeid = 1
   INNER JOIN idq_production_eks.itemgtin_1 AS GTIN ON FALSE) AS eas,
  CASE
  WHEN stmara_eks_item.ziscurrentcontractfromsk = 1 AND stmara_eks_item.ziscurrentcontract = 0
  THEN SK.zrelevantmdm
  ELSE CAST(stmara_eks_item.zrelevantmdm AS STRING)
  END AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive,
 stmara_eks_item.znegotiatingcountry
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.item_1 AS IT ON stmara_eks_item.itemid = IT.itemid AND IT.brandtypeid = 1
 INNER JOIN idq_production_eks.itemgtin_1 AS ITG ON stmara_eks_item.itemid = ITG.itemid
 LEFT JOIN (SELECT xteks_basicinfo_reccountry.itemid,
   MIN(CAST(stmara_eks_item0.zrelevantmdm AS STRING)) AS zrelevantmdm
  FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item0 ON xteks_basicinfo_reccountry.sk_itemid
     = stmara_eks_item0.itemid
  GROUP BY xteks_basicinfo_reccountry.itemid) AS SK ON stmara_eks_item.itemid = SK.itemid
WHERE stmara_eks_item.zarticletype = 'EA'
 AND (stmara_eks_item.zactive = 1 OR stmara_eks_item.ziscurrentcontract = 1 OR stmara_eks_item.ziscurrentcontractfromsk
    = 1)
 AND ITG.gtin IN (SELECT ITG1.gtin
   FROM idq_production_eks.itemgtin_1 AS ITG1
    INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS IT1 ON ITG1.itemid = IT1.itemid AND ITG1.no_gtin = 0
     AND (IT1.zactive = 1 OR IT1.ziscurrentcontract = 1 OR IT1.ziscurrentcontractfromsk = 1)
    INNER JOIN idq_production_eks.item_1 AS IT2 ON IT1.itemid = IT2.itemid AND IT2.brandtypeid = 1
   GROUP BY ITG1.gtin
   HAVING COUNT(DISTINCT IT1.itemno) > 1);