CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_commodity_code_missingsel_all_2 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description_int,
supplierno, supplierdescription, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry
 AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int,
 supplier.intsupplierno AS supplierno,
 supplier.description AS supplierdescription,
 xteks_basicinfo_reccountry.ziswawirelevant AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item_2
 LEFT JOIN idq_production_eks.itemintrastat_2 ON stmara_eks_item.itemid = itemintrastat.itemid
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_2 ON stmara_eks_item.itemno =
  xteks_basicinfo_reccountry.itemno
 INNER JOIN idq_production_eks.supplier_2 ON xteks_basicinfo_reccountry.supplierno = supplier.supplierno
WHERE (itemintrastat.intrastat IS NULL OR itemintrastat.intrastat = '')
 AND stmara_eks_item.constructed IS NULL
 AND stmara_eks_item.zactive = 1
 AND stmara_eks_item.zarticletype = 'EA'
 AND stmara_eks_item.itemid IN (SELECT itemid
   FROM idq_production_eks_calculation.svmara_eks_item_ea_receivingcountry_2
   WHERE receivingcountry NOT IN ('US', 'LX', 'EW', 'CH'))
 AND xteks_basicinfo_reccountry.receivingcountry NOT IN ('US', 'LX', 'EW', 'CH');