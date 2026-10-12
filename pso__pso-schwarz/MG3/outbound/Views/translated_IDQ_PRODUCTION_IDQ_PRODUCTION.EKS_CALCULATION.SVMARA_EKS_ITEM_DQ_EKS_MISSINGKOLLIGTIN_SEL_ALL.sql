CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_missingkolligtin_sel_all (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description_int,
decimalcasesize, kolligtin, listingoverviewid, supplierno, supplierdescription, zrelevantmdm, zsource, zactive) AS
SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int,
 xteks_basicinfo_reccountry.decimalcasesize,
 itg.gtin AS kolligtin,
 xteks_basicinfo_reccountry.listingoverviewid,
 supplier.intsupplierno AS supplierno,
 supplier.description AS supplierdescription,
 xteks_basicinfo_reccountry.ziswawirelevant AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_union ON stmara_eks_item.itemid = xteks_basicinfo_union.itemid
  
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON xteks_basicinfo_union.casesize =
   xteks_basicinfo_reccountry.casesize AND (stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.itemid =
      xteks_basicinfo_reccountry.itemid OR stmara_eks_item.zarticletype = 'SK' AND stmara_eks_item.itemid =
      xteks_basicinfo_reccountry.sk_itemid)
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_dq_eks_missingkolligtin_010 ON xteks_basicinfo_reccountry.listingoverviewid
   = svmara_eks_item_dq_eks_missingkolligtin_010.listingoverviewid
 INNER JOIN idq_production_eks.item ON item.brandtypeid IN (1) AND xteks_basicinfo_reccountry.itemid = item.itemid
 LEFT JOIN idq_production_eks.supplier ON xteks_basicinfo_reccountry.supplierno = supplier.supplierno
 LEFT JOIN idq_production_eks.itemgtin AS itg ON stmara_eks_item.itemid = itg.itemid AND (itg.casesize IS NULL OR CAST(itg.casesize AS FLOAT64)
     = xteks_basicinfo_reccountry.decimalcasesize)
WHERE stmara_eks_item.zactive = 1 AND xteks_basicinfo_reccountry.sk_itemid IS NULL AND stmara_eks_item.zarticletype =
   'EA'
 OR stmara_eks_item.zactive = 1 AND stmara_eks_item.zarticletype = 'SK' AND xteks_basicinfo_reccountry.sk_itemid
  IS NOT NULL;