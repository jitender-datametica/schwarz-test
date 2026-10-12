CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_missinggewart_sel (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description, text_nat
, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 itemdetail.text_nat,
 xteks_basicinfo_reccountry.ziswawirelevant AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON stmara_eks_item.itemid =
  xteks_basicinfo_reccountry.itemid
 LEFT JOIN idq_production_eks.itemdetail ON stmara_eks_item.itemid = itemdetail.itemid
WHERE (stmara_eks_item.zactive = 1 OR stmara_eks_item.ziscurrentcontract = 1 OR stmara_eks_item.ziscurrentcontractfromsk
     = 1)
 AND itemdetail.text_int IS NULL
 AND stmara_eks_item.znegotiatingcountry NOT IN ('AT', 'DE', 'CH')
 AND itemdetail.text_nat IS NOT NULL;