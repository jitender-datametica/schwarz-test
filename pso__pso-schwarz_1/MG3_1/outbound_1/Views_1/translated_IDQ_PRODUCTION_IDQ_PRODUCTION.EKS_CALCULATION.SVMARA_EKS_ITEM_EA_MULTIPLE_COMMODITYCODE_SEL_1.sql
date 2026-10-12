CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_ea_multiple_commoditycode_sel_1 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
intrastat, zrelevantmdm, zsource, zactive) AS SELECT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 itemintrastat.intrastat,
  CASE
  WHEN stmara_eks_item.ziscurrentcontractfromsk = 1 AND stmara_eks_item.ziscurrentcontract = 0
  THEN SK.zrelevantmdm
  ELSE stmara_eks_item.zrelevantmdm
  END AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks.itemintrastat_1
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 ON itemintrastat.itemid = stmara_eks_item.itemid
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_ea_multiple_commoditycode_01_sel_1 ON stmara_eks_item.itemid =
  svmara_eks_item_ea_multiple_commoditycode_01_sel.itemid
 LEFT JOIN (SELECT xteks_basicinfo_reccountry.itemid,
   MIN(stmara_eks_item0.zrelevantmdm) AS zrelevantmdm
  FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item0 ON xteks_basicinfo_reccountry.sk_itemid
     = stmara_eks_item0.itemid
  GROUP BY xteks_basicinfo_reccountry.itemid) AS SK ON stmara_eks_item.itemid = SK.itemid
WHERE stmara_eks_item.ziscurrentcontract = 1
 OR stmara_eks_item.ziscurrentcontractfromsk = 1;