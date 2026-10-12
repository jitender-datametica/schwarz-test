CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_differentbaseuomwithinconstruct_sel_1 (negotiatingcountry
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
   ba.itemno AS ba_itemno,
   stmara_eks_item.itemid,
   stmara_eks_item.itemno,
   stmara_eks_item.zarticletype AS articletype,
   stmara_eks_item.description_int AS description,
   itd.bundlefact,
   itd.volume,
   tr.description AS unitdescription,
   itd.text_int AS zusatz_gew_art_int,
   itd.text_nat AS zusatz_gew_art_nat,
   stmara_eks_item.zmeins AS baseuom,
    CASE
    WHEN stmara_eks_item.ziscurrentcontract = 1
    THEN stmara_eks_item.zrelevantmdm
    ELSE SK.zrelevantmdm
    END AS zrelevantmdm,
   stmara_eks_item.zsource,
   stmara_eks_item.zactive,
   stmara_eks_item.zitem_ba
  FROM idq_production_eks_calculation.stmara_eks_item_1
   INNER JOIN idq_production_eks_calculation.svmara_eks_item_differentbaseuom_01_1 ON stmara_eks_item.zitem_ba =
    svmara_eks_item_differentbaseuom_01.zitem_ba
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS ba ON svmara_eks_item_differentbaseuom_01.zitem_ba = ba
    .itemid
   LEFT JOIN idq_production_eks.itemdetail_1 AS itd ON stmara_eks_item.itemid = itd.itemid
   LEFT JOIN idq_production_eks.unit_1 AS un ON itd.unitid = un.unitid
   LEFT JOIN idq_production_eks.translation_int_1 AS tr ON un.shortdescid = tr.translationid
   LEFT JOIN (SELECT xteks_basicinfo_reccountry.itemid,
     MIN(stmara_eks_item0.zrelevantmdm) AS zrelevantmdm
    FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1
     INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item0 ON xteks_basicinfo_reccountry.sk_itemid
       = stmara_eks_item0.itemid
    GROUP BY xteks_basicinfo_reccountry.itemid) AS SK ON stmara_eks_item.itemid = SK.itemid
  WHERE stmara_eks_item.zactive = 1
   AND stmara_eks_item.zarticletype = 'EA'
  ORDER BY stmara_eks_item.zitem_ba NULLS LAST) AS t2;