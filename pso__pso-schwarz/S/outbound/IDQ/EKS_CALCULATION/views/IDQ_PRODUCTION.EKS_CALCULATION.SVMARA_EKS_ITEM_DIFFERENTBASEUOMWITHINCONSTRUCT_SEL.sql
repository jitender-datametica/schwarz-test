CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_differentbaseuomwithinconstruct_sel (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, ba_itemno, itemid, itemno, articletype,
description, bundlefact, volume, unitdescription, zusatz_gew_art_int, zusatz_gew_art_nat, baseuom, zrelevantmdm, zsource
, zactive) AS SELECT t2.negotiatingcountry,
 t2.buyershortsign,
 t2.buyerfirstname,
 t2.buyerlastname,
 t2.zmatkl,
 t2.articlefamily,
 t2.ba_itemno,
 t2.itemid,
 t2.itemno,
 t2.articletype,
 t2.description,
 t2.bundlefact,
 t2.volume,
 t2.unitdescription,
 t2.zusatz_gew_art_int,
 t2.zusatz_gew_art_nat,
 t2.baseuom,
 t2.zrelevantmdm,
 t2.zsource,
 t2.zactive
FROM (SELECT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
   stmara_eks_item.buyershortsign,
   stmara_eks_item.buyerfirstname,
   stmara_eks_item.buyerlastname,
   stmara_eks_item.zmatkl,
   stmara_eks_item.articlefamily,
   BA.itemno AS ba_itemno,
   stmara_eks_item.itemid,
   stmara_eks_item.itemno,
   stmara_eks_item.zarticletype AS articletype,
   stmara_eks_item.description_int AS description,
   ITD.bundlefact,
   ITD.volume,
   TR.description AS unitdescription,
   ITD.text_int AS zusatz_gew_art_int,
   ITD.text_nat AS zusatz_gew_art_nat,
   stmara_eks_item.zmeins AS baseuom,
    CASE
    WHEN stmara_eks_item.ziscurrentcontract = 1
    THEN stmara_eks_item.zrelevantmdm
    ELSE SK.zrelevantmdm
    END AS zrelevantmdm,
   stmara_eks_item.zsource,
   stmara_eks_item.zactive,
   stmara_eks_item.zitem_ba
  FROM idq_production_eks_calculation.stmara_eks_item
   INNER JOIN idq_production_eks_calculation.svmara_eks_item_differentbaseuom_01 ON stmara_eks_item.zitem_ba =
    svmara_eks_item_differentbaseuom_01.zitem_ba
   INNER JOIN idq_production_eks_calculation.stmara_eks_item AS BA ON svmara_eks_item_differentbaseuom_01.zitem_ba = BA
    .itemid
   LEFT JOIN idq_production_eks.itemdetail AS ITD ON stmara_eks_item.itemid = ITD.itemid
   LEFT JOIN idq_production_eks.unit AS UN ON ITD.unitid = UN.unitid
   LEFT JOIN idq_production_eks.translation_int AS TR ON UN.shortdescid = TR.translationid
   LEFT JOIN (SELECT xteks_basicinfo_reccountry.itemid,
     MIN(stmara_eks_item0.zrelevantmdm) AS zrelevantmdm
    FROM idq_production_eks_calculation.xteks_basicinfo_reccountry
     INNER JOIN idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item0 ON xteks_basicinfo_reccountry.sk_itemid
       = stmara_eks_item0.itemid
    GROUP BY xteks_basicinfo_reccountry.itemid) AS SK ON stmara_eks_item.itemid = SK.itemid
  WHERE stmara_eks_item.zactive = 1
   AND stmara_eks_item.zarticletype = 'EA'
  ORDER BY stmara_eks_item.zitem_ba NULLS LAST) AS t2;