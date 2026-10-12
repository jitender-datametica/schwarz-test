CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_palletutilisationunder50orover120_sel_2 AS
WITH CTE AS (SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
    stmara_eks_item.buyershortsign,
    stmara_eks_item.buyerfirstname,
    stmara_eks_item.buyerlastname,
    stmara_eks_item.articlefamily,
    stmara_eks_item.zmatkl,
    stmara_eks_item.itemid,
    stmara_eks_item.itemno,
    stmara_eks_item.zarticletype AS articletype,
    stmara_eks_item.description_int,
    BP.casesize,
    BP.decimalcasesize,
    STRUC.ea_itemno,
    STRUC.ea_description,
    STRUC.sk_itemno,
    STRUC.sk_description,
    STRUC.ba_itemno,
    STRUC.ba_description,
    BP.listingoverviewid,
    BP.supplierno,
    BP.receivingcountry,
    BP.contractpricevalidityid,
    BP.ziswawirelevant AS zrelevantmdm,
    stmara_eks_item.zsource,
    stmara_eks_item.zactive
   FROM idq_production_eks_calculation.stmara_eks_item_2
    INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_2 AS BP ON stmara_eks_item.itemid = BP.itemid AND
     BP.sk_itemno IS NULL
    INNER JOIN idq_production_eks_calculation.svmara_eks_item_baskea_structure_010_2 AS STRUC ON stmara_eks_item.itemno =
       STRUC.ea_itemno AND stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.ziscurrentcontract = 1
   WHERE STRUC.sk_itemno IS NULL
   UNION DISTINCT
   SELECT DISTINCT stmara_eks_item0.znegotiatingcountry AS negotiatingcountry,
    stmara_eks_item0.buyershortsign,
    stmara_eks_item0.buyerfirstname,
    stmara_eks_item0.buyerlastname,
    stmara_eks_item0.articlefamily,
    stmara_eks_item0.zmatkl,
    stmara_eks_item0.itemid,
    stmara_eks_item0.itemno,
    stmara_eks_item0.zarticletype AS articletype,
    stmara_eks_item0.description_int,
    BP.casesize,
    BP.decimalcasesize,
    STRUC.ea_itemno,
    STRUC.ea_description,
    STRUC.sk_itemno,
    STRUC.sk_description,
    STRUC.ba_itemno,
    STRUC.ba_description,
    BP.listingoverviewid,
    BP.supplierno,
    BP.receivingcountry,
    BP.contractpricevalidityid,
    BP.ziswawirelevant AS zrelevantmdm,
    stmara_eks_item0.zsource,
    stmara_eks_item0.zactive
   FROM idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item0
    INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_2 AS BP ON stmara_eks_item0.itemid = BP.sk_itemid
     
    INNER JOIN idq_production_eks_calculation.svmara_eks_item_baskea_structure_010_2 AS STRUC ON stmara_eks_item0.itemno =
       STRUC.sk_itemno AND stmara_eks_item0.zarticletype = 'SK' AND stmara_eks_item0.ziscurrentcontract = 1) (SELECT
  DISTINCT t5.negotiatingcountry,
   t5.buyershortsign,
   t5.buyerfirstname,
   t5.buyerlastname,
   t5.zmatkl,
   t5.articlefamily,
   t5.itemid,
   t5.itemno,
   t5.articletype,
   t5.description_int AS description,
   t5.decimalcasesize,
   ITD.casedepth,
   ITD.casewidth,
   ITD.caseheight,
    CAST(itemcasepaldef.usage AS STRING) || '%' AS usage,
   t5.listingoverviewid,
   SUP.intsupplierno AS supplierno,
   SUP.description AS supplierdescription,
   t5.receivingcountry,
   t5.zrelevantmdm,
   t5.zsource,
   t5.zactive
  FROM CTE AS t5
   INNER JOIN idq_production_eks.itemdimension_2 AS ITD ON t5.itemid = ITD.itemid AND t5.contractpricevalidityid = ITD.contractpricevalidityid
     
   INNER JOIN idq_production_eks.supplier_2 AS SUP ON t5.supplierno = SUP.supplierno
   INNER JOIN idq_production_eks.listingoverview_2 ON t5.listingoverviewid = listingoverview.listingoverviewid
   LEFT JOIN idq_production_eks.loheading_2 AS LH ON listingoverview.loheadingid = LH.loheadingid
   LEFT JOIN idq_production_eks.translation_int_2 AS TR_LH ON LH.descriptionid = TR_LH.translationid
   LEFT JOIN idq_production_eks.locategory_2 AS LC ON listingoverview.locategoryid = LC.locategoryid AND listingoverview.locategoryid
      <> 4
   LEFT JOIN idq_production_eks.translation_int_2 AS TR_LC ON LC.descriptionid = TR_LC.translationid
   LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist_2 ON t5.itemno = eks_zsm_excludelist.itemno AND (SUP.intsupplierno
            = eks_zsm_excludelist.supplierno AND eks_zsm_excludelist.listingoverviewid IS NULL OR t5.listingoverviewid =
           eks_zsm_excludelist.listingoverviewid AND eks_zsm_excludelist.supplierno IS NULL OR SUP.intsupplierno =
          eks_zsm_excludelist.supplierno AND t5.listingoverviewid = eks_zsm_excludelist.listingoverviewid OR
        eks_zsm_excludelist.supplierno IS NULL AND eks_zsm_excludelist.listingoverviewid IS NULL) AND
     eks_zsm_excludelist.reportno = '027'
   LEFT JOIN idq_production_eks.itemcasepaldef_2 ON t5.contractpricevalidityid = itemcasepaldef.contractpricevalidityid
  WHERE (itemcasepaldef.usage IS NULL AND t5.zmatkl <> '73' AND t5.zmatkl <> '84' OR t5.zmatkl <> '73' AND t5.zmatkl <>
         '84' AND CASE
         WHEN itemcasepaldef.usage = 0 AND LOWER(TR_LH.description) LIKE '%dezentral%'
         THEN 0
         WHEN itemcasepaldef.usage = 0 AND LOWER(TR_LC.description) LIKE '%filialbelieferung%'
         THEN 0
         ELSE 1
         END = 1 AND NOT itemcasepaldef.usage BETWEEN 50 AND 120)
   AND eks_zsm_excludelist.itemno IS NULL);