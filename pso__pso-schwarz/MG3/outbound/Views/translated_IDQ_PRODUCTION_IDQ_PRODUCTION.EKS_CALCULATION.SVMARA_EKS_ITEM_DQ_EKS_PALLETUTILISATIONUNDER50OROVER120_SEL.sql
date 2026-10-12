CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_palletutilisationunder50orover120_sel AS
WITH cte AS (SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
    stmara_eks_item.buyershortsign,
    stmara_eks_item.buyerfirstname,
    stmara_eks_item.buyerlastname,
    stmara_eks_item.articlefamily,
    stmara_eks_item.zmatkl,
    stmara_eks_item.itemid,
    stmara_eks_item.itemno,
    stmara_eks_item.zarticletype AS articletype,
    stmara_eks_item.description_int,
    bp.casesize,
    bp.decimalcasesize,
    struc.ea_itemno,
    struc.ea_description,
    struc.sk_itemno,
    struc.sk_description,
    struc.ba_itemno,
    struc.ba_description,
    bp.listingoverviewid,
    bp.supplierno,
    bp.receivingcountry,
    bp.contractpricevalidityid,
    bp.ziswawirelevant AS zrelevantmdm,
    stmara_eks_item.zsource,
    stmara_eks_item.zactive
   FROM idq_production_eks_calculation.stmara_eks_item
    INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry AS bp ON stmara_eks_item.itemid = bp.itemid AND
     bp.sk_itemno IS NULL
    INNER JOIN idq_production_eks_calculation.svmara_eks_item_baskea_structure_010 AS struc ON stmara_eks_item.itemno =
       struc.ea_itemno AND stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.ziscurrentcontract = 1
   WHERE struc.sk_itemno IS NULL
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
    bp.casesize,
    bp.decimalcasesize,
    struc.ea_itemno,
    struc.ea_description,
    struc.sk_itemno,
    struc.sk_description,
    struc.ba_itemno,
    struc.ba_description,
    bp.listingoverviewid,
    bp.supplierno,
    bp.receivingcountry,
    bp.contractpricevalidityid,
    bp.ziswawirelevant AS zrelevantmdm,
    stmara_eks_item0.zsource,
    stmara_eks_item0.zactive
   FROM idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item0
    INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry AS bp ON stmara_eks_item0.itemid = bp.sk_itemid
     
    INNER JOIN idq_production_eks_calculation.svmara_eks_item_baskea_structure_010 AS struc ON stmara_eks_item0.itemno =
       struc.sk_itemno AND stmara_eks_item0.zarticletype = 'SK' AND stmara_eks_item0.ziscurrentcontract = 1) (SELECT
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
   itd.casedepth,
   itd.casewidth,
   itd.caseheight,
    CAST(itemcasepaldef.usage AS STRING) || '%' AS usage,
   t5.listingoverviewid,
   sup.intsupplierno AS supplierno,
   sup.description AS supplierdescription,
   t5.receivingcountry,
   t5.zrelevantmdm,
   t5.zsource,
   t5.zactive
  FROM cte AS t5
   INNER JOIN idq_production_eks.itemdimension AS itd ON t5.itemid = itd.itemid AND t5.contractpricevalidityid = itd.contractpricevalidityid
     
   INNER JOIN idq_production_eks.supplier AS sup ON t5.supplierno = sup.supplierno
   INNER JOIN idq_production_eks.listingoverview ON t5.listingoverviewid = listingoverview.listingoverviewid
   LEFT JOIN idq_production_eks.loheading AS lh ON listingoverview.loheadingid = lh.loheadingid
   LEFT JOIN idq_production_eks.translation_int AS tr_lh ON lh.descriptionid = tr_lh.translationid
   LEFT JOIN idq_production_eks.locategory AS lc ON listingoverview.locategoryid = lc.locategoryid AND listingoverview.locategoryid
      <> 4
   LEFT JOIN idq_production_eks.translation_int AS tr_lc ON lc.descriptionid = tr_lc.translationid
   LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist ON t5.itemno = eks_zsm_excludelist.itemno AND (sup.intsupplierno
            = eks_zsm_excludelist.supplierno AND eks_zsm_excludelist.listingoverviewid IS NULL OR t5.listingoverviewid =
           eks_zsm_excludelist.listingoverviewid AND eks_zsm_excludelist.supplierno IS NULL OR sup.intsupplierno =
          eks_zsm_excludelist.supplierno AND t5.listingoverviewid = eks_zsm_excludelist.listingoverviewid OR
        eks_zsm_excludelist.supplierno IS NULL AND eks_zsm_excludelist.listingoverviewid IS NULL) AND
     eks_zsm_excludelist.reportno = '027'
   LEFT JOIN idq_production_eks.itemcasepaldef ON t5.contractpricevalidityid = itemcasepaldef.contractpricevalidityid
  WHERE (itemcasepaldef.usage IS NULL AND t5.zmatkl <> '73' AND t5.zmatkl <> '84' OR t5.zmatkl <> '73' AND t5.zmatkl <>
         '84' AND CASE
         WHEN itemcasepaldef.usage = 0 AND LOWER(tr_lh.description) LIKE '%dezentral%'
         THEN 0
         WHEN itemcasepaldef.usage = 0 AND LOWER(tr_lc.description) LIKE '%filialbelieferung%'
         THEN 0
         ELSE 1
         END = 1 AND NOT itemcasepaldef.usage BETWEEN 50 AND 120)
   AND eks_zsm_excludelist.itemno IS NULL);