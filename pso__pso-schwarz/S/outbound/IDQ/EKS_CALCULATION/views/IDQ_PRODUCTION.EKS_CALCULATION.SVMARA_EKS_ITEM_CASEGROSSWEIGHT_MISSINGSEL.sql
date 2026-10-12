CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_casegrossweight_missingsel (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
listingoverviewid, supplierno, supplierdescription, receivingcountry, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT
 stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 steks_listingoverviewmax.listingoverviewid,
 supplier.intsupplierno AS supplierno,
 supplier.description AS supplierdescription,
 steks_listingoverviewmax.receivingcountry,
 xteks_basicinfo_reccountry.ziswawirelevant AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN (idq_production_eks.supplier INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax ON supplier
   .supplierno = steks_listingoverviewmax.supplierno) ON stmara_eks_item.itemid = steks_listingoverviewmax.itemid
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_union ON steks_listingoverviewmax.listingoverviewid =
     xteks_basicinfo_union.listingoverviewid AND steks_listingoverviewmax.casesize = xteks_basicinfo_union.casesize AND
    steks_listingoverviewmax.itemid = xteks_basicinfo_union.itemid AND steks_listingoverviewmax.receivingcountry =
   xteks_basicinfo_union.recievingcountry
 LEFT JOIN idq_production_eks.itemweight ON xteks_basicinfo_union.contractpricevalidityid = itemweight.contractpricevalidityid
    AND steks_listingoverviewmax.itemid = itemweight.itemid
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON xteks_basicinfo_union.listingoverviewid =
       xteks_basicinfo_reccountry.listingoverviewid AND xteks_basicinfo_union.casesize = xteks_basicinfo_reccountry.casesize
        AND supplier.supplierno = xteks_basicinfo_reccountry.supplierno AND xteks_basicinfo_union.recievingcountry =
     xteks_basicinfo_reccountry.receivingcountry AND (xteks_basicinfo_union.itemid = xteks_basicinfo_reccountry.itemid
      AND xteks_basicinfo_union.zarticletype = 'EA' OR xteks_basicinfo_union.zarticletype = 'SK' AND
      xteks_basicinfo_reccountry.sk_itemid IS NOT NULL) AND xteks_basicinfo_union.basicpriceid =
   xteks_basicinfo_reccountry.basicpriceid
 INNER JOIN idq_production_eks.listingoverview AS LIST ON xteks_basicinfo_reccountry.listingoverviewid = LIST.listingoverviewid
    AND xteks_basicinfo_reccountry.supplierno = LIST.supplierno
 LEFT JOIN idq_production_eks.locategory AS LOC ON LIST.locategoryid = LOC.locategoryid
 LEFT JOIN idq_production_eks.translation_int AS TRANS_LOC ON LOC.descriptionid = TRANS_LOC.translationid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist ON stmara_eks_item.itemno = eks_zsm_excludelist.itemno AND
    (supplier.intsupplierno = eks_zsm_excludelist.supplierno AND eks_zsm_excludelist.listingoverviewid IS NULL OR
         steks_listingoverviewmax.listingoverviewid = eks_zsm_excludelist.listingoverviewid AND eks_zsm_excludelist.supplierno
        IS NULL OR supplier.intsupplierno = eks_zsm_excludelist.supplierno AND steks_listingoverviewmax.listingoverviewid
         = eks_zsm_excludelist.listingoverviewid OR eks_zsm_excludelist.supplierno IS NULL AND eks_zsm_excludelist.listingoverviewid
      IS NULL) AND eks_zsm_excludelist.reportno = '023'
WHERE (itemweight.casegrossweight IS NULL AND stmara_eks_item.constructed IS NULL AND stmara_eks_item.ziscurrentcontract
       = 1 AND LOWER(TRANS_LOC.description) NOT LIKE '%filialbelieferung%' OR itemweight.casegrossweight IS NULL AND
      stmara_eks_item.constructed IS NULL AND stmara_eks_item.ziscurrentcontractfromsk = 1 AND LOWER(TRANS_LOC.description
      ) NOT LIKE '%filialbelieferung%')
 AND eks_zsm_excludelist.itemno IS NULL
 AND stmara_eks_item.zactive = 1;