CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_nettweight_different_packcontent_sel_all (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
zzz_quant_pack_cont, zzz_pack_content, zzz_pack_cont_uom, packagepackaging, eks_nettweight, zrelevantmdm, zsource,
zactive) AS SELECT svmara_eks_item_nettweight_different_packcontent_030.znegotiatingcountry AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 svmara_eks_item_nettweight_different_packcontent_030.itemid,
 svmara_eks_item_nettweight_different_packcontent_030.itemno,
 svmara_eks_item_nettweight_different_packcontent_030.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 stmara_eks_item.zzz_quant_pack_cont,
 stmara_eks_item.zzz_pack_content,
 stmara_eks_item.zzz_pack_cont_uom,
 svmara_eks_item_nettweight_different_packcontent_030.packagepackaging,
 svmara_eks_item_nettweight_different_packcontent_030.eks_nettweight,
  CASE
  WHEN stmara_eks_item.ziscurrentcontractfromsk = 1 AND stmara_eks_item.ziscurrentcontract = 0
  THEN SK.zrelevantmdm
  ELSE stmara_eks_item.zrelevantmdm
  END AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.svmara_eks_item_nettweight_different_packcontent_030
 INNER JOIN idq_production_eks_calculation.stmara_eks_item ON svmara_eks_item_nettweight_different_packcontent_030.itemid
   = stmara_eks_item.itemid
 LEFT JOIN (SELECT xteks_basicinfo_reccountry.itemid,
   MIN(stmara_eks_item0.zrelevantmdm) AS zrelevantmdm
  FROM idq_production_eks_calculation.xteks_basicinfo_reccountry
   INNER JOIN idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item0 ON xteks_basicinfo_reccountry.sk_itemid
     = stmara_eks_item0.itemid
  GROUP BY xteks_basicinfo_reccountry.itemid) AS SK ON stmara_eks_item.itemid = SK.itemid
WHERE stmara_eks_item.zactive = 1 AND stmara_eks_item.zmatkl <> '74' AND stmara_eks_item.itemid IN (SELECT itemid
    FROM idq_production_eks_calculation.svmara_eks_item_ea_receivingcountry
    WHERE receivingcountry NOT IN ('US', 'LX', 'EW', 'CH'))
 OR stmara_eks_item.zactive = 1 AND stmara_eks_item.zmatkl <> '74' AND stmara_eks_item.itemid IN (SELECT itemid
     FROM idq_production_eks_calculation.svmara_eks_item_ea_receivingcountry AS svmara_eks_item_ea_receivingcountry_2
     WHERE receivingcountry NOT IN ('US', 'LX', 'EW', 'CH')) AND stmara_eks_item.ziscurrentcontract = 1
 OR stmara_eks_item.zactive = 1 AND stmara_eks_item.zmatkl <> '74' AND stmara_eks_item.itemid IN (SELECT itemid
     FROM idq_production_eks_calculation.svmara_eks_item_ea_receivingcountry AS svmara_eks_item_ea_receivingcountry_1
     WHERE receivingcountry NOT IN ('US', 'LX', 'EW', 'CH')) AND stmara_eks_item.ziscurrentcontractfromsk = 1;