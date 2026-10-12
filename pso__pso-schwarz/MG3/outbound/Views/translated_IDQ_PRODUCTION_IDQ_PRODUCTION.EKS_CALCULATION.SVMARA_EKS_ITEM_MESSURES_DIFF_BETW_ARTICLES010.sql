CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_messures_diff_betw_articles010 AS WITH cte AS (SELECT
    xteks_basicinfo_reccountry.listingoverviewid,
    xteks_basicinfo_reccountry.casesize,
    xteks_basicinfo_reccountry.decimalcasesize,
    svmara_eks_item_baskea_structure_010.ba_itemno,
    xteks_basicinfo_reccountry.sk_itemid AS itemid,
    xteks_basicinfo_reccountry.contractpricevalidityid,
    xteks_basicinfo_reccountry.contractpricerelid,
    xteks_basicinfo_reccountry.supplierno,
    xteks_basicinfo_reccountry.receivingcountry,
    xteks_basicinfo_reccountry.ziswawirelevant
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry
    INNER JOIN idq_production_eks_calculation.svmara_eks_item_baskea_structure_010 ON xteks_basicinfo_reccountry.sk_itemno
      = svmara_eks_item_baskea_structure_010.sk_itemno
   WHERE xteks_basicinfo_reccountry.sk_itemid IS NOT NULL
   UNION DISTINCT
   SELECT xteks_basicinfo_reccountry0.listingoverviewid,
    xteks_basicinfo_reccountry0.casesize,
    xteks_basicinfo_reccountry0.decimalcasesize,
    svmara_eks_item_baskea_structure_0100.ba_itemno,
    xteks_basicinfo_reccountry0.itemid,
    xteks_basicinfo_reccountry0.contractpricevalidityid,
    xteks_basicinfo_reccountry0.contractpricerelid,
    xteks_basicinfo_reccountry0.supplierno,
    xteks_basicinfo_reccountry0.receivingcountry,
    xteks_basicinfo_reccountry0.ziswawirelevant
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry AS xteks_basicinfo_reccountry0
    INNER JOIN idq_production_eks_calculation.svmara_eks_item_baskea_structure_010 AS
    svmara_eks_item_baskea_structure_0100 ON xteks_basicinfo_reccountry0.itemno = svmara_eks_item_baskea_structure_0100
     .ea_itemno
   WHERE xteks_basicinfo_reccountry0.sk_itemid IS NULL) (SELECT DISTINCT t4.ziswawirelevant AS zrelevantmdm,
   stmara_eks_item.zsource,
   stmara_eks_item.zactive,
   stmara_eks_item.znegotiatingcountry,
   stmara_eks_item.zitem_ba,
   t4.itemid,
   stmara_eks_item.itemno,
   stmara_eks_item.description_int,
   stmara_eks_item.zmatkl,
   t4.casesize,
   itemdimension.caseheight,
   itemdimension.casewidth,
   itemdimension.casedepth,
   stmara_eks_item.zarticletype,
   stmara_eks_item.buyerid,
   stmara_eks_item.buyerfirstname,
   stmara_eks_item.buyerlastname,
   stmara_eks_item.buyershortsign,
   stmara_eks_item.articlefamily,
   stmara_eks_item.ziscurrentcontract,
   t4.decimalcasesize AS subcasesize,
   t4.ba_itemno,
   t4.listingoverviewid,
    CASE
    WHEN tr.description = 'mm'
    THEN ROUND(CAST(itemdimension.casedepth AS NUMERIC), 2) / 1000 * ROUND(CAST(itemdimension.casewidth AS NUMERIC), 2)
       / 1000 * ROUND(CAST(itemdimension.caseheight AS NUMERIC), 2) / 1000
    WHEN tr.description = 'cm'
    THEN ROUND(CAST(itemdimension.casedepth AS NUMERIC), 2) / 100 * ROUND(CAST(itemdimension.casewidth AS NUMERIC), 2) /
       100 * ROUND(CAST(itemdimension.caseheight AS NUMERIC), 2) / 100
    WHEN tr.description = 'in'
    THEN ROUND(CAST(itemdimension.casedepth AS NUMERIC), 2) / 39.37 * ROUND(CAST(itemdimension.casewidth AS NUMERIC), 2
         ) / 39.37 * ROUND(CAST(itemdimension.caseheight AS NUMERIC), 2) / 39.37
    WHEN tr.description = 'm'
    THEN ROUND(CAST(itemdimension.casedepth AS NUMERIC), 2) * ROUND(CAST(itemdimension.casewidth AS NUMERIC), 2) * ROUND(CAST(itemdimension.caseheight AS NUMERIC)
      , 2)
    ELSE NULL
    END AS volume,
   t4.receivingcountry,
   tr.description AS unitdescription,
   supplier.intsupplierno AS supplierno,
   supplier.description AS supplierdescription
  FROM idq_production_eks_calculation.stmara_eks_item
   INNER JOIN cte AS t4 ON stmara_eks_item.itemid = t4.itemid
   INNER JOIN idq_production_eks.itemdimension ON t4.contractpricevalidityid = itemdimension.contractpricevalidityid AND
     stmara_eks_item.itemid = itemdimension.itemid
   INNER JOIN idq_production_eks.unit ON itemdimension.caseunitid = unit.unitid
   INNER JOIN idq_production_eks.translation_int_unit AS tr ON unit.shortdescid = tr.translationid
   LEFT JOIN idq_production_eks.supplier ON t4.supplierno = supplier.supplierno);