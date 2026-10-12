CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_ean_duplicate_eas_sel_2 (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description, ean_2,
additional_gtin, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS
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
 itemean.ean_2,
  (SELECT STRING_AGG(CONCAT(a.znegotiatingcountry, '-', a.zlegacymatnr), ', ' ORDER BY a.znegotiatingcountry IS NULL, a
     .znegotiatingcountry, a.zlegacymatnr IS NULL, a.zlegacymatnr)
  FROM idq_production_eks_calculation.stmara_eks_item_2 AS a
   INNER JOIN idq_production_eks.itemean_2 AS ean_2 ON FALSE) AS additional_gtin,
 svmara_eks_item_ean_duplicate_03_sel.ziswawirelevant AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.svmara_eks_item_ean_duplicate_03_sel_2
 INNER JOIN idq_production_eks.itemean_2 ON svmara_eks_item_ean_duplicate_03_sel.ean_2 = itemean.ean_2
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON itemean.itemid = stmara_eks_item.itemid;