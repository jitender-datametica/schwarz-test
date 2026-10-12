CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_with_measure_gt_cm_sel (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
casedepth, casewidth, caseheight, unitdescription, volume, casesize, decimalcasesize, listingoverviewid, supplierno,
supplierdescription, receivingcountry, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry
  AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 itemdimension.casedepth,
 itemdimension.casewidth,
 itemdimension.caseheight,
 translation_int_unit.description AS unitdescription,
 svmara_eks_item_messures_diff_betw_articles010.volume,
 eks.casesize,
 eks.decimalcasesize,
 eks.listingoverviewid,
 supplier.intsupplierno AS supplierno,
 supplier.description AS supplierdescription,
 eks.receivingcountry,
 eks.zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN (SELECT DISTINCT 'EA' AS articletype,
    itemid,
    itemno,
    listingoverviewid,
    casesize,
    receivingcountry,
    supplierno,
    contractlinkid,
    contractpricevalidityid,
    decimalcasesize,
    contractpricerelid,
    ziswawirelevant AS zrelevantmdm
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry
   WHERE sk_itemno IS NULL
   UNION ALL
   SELECT DISTINCT 'SK' AS articletype,
    sk_itemid AS itemid,
    sk_itemno AS itemno,
    listingoverviewid,
    casesize,
    receivingcountry,
    supplierno,
    contractlinkid,
    contractpricevalidityid,
    decimalcasesize,
    contractpricerelid,
    ziswawirelevant AS zrelevantmdm
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry
   WHERE sk_itemid IS NOT NULL) AS eks ON stmara_eks_item.itemid = eks.itemid
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_messures_diff_betw_articles010 ON eks.itemid =
     svmara_eks_item_messures_diff_betw_articles010.itemid AND eks.listingoverviewid =
     svmara_eks_item_messures_diff_betw_articles010.listingoverviewid AND eks.casesize =
    svmara_eks_item_messures_diff_betw_articles010.casesize AND eks.receivingcountry =
   svmara_eks_item_messures_diff_betw_articles010.receivingcountry
 INNER JOIN idq_production_eks.contractpricevalidity ON eks.contractpricevalidityid = contractpricevalidity.contractpricevalidityid
  
 INNER JOIN idq_production_eks.itemdimension ON eks.contractpricevalidityid = itemdimension.contractpricevalidityid AND
   stmara_eks_item.itemid = itemdimension.itemid
 INNER JOIN idq_production_eks.unit ON itemdimension.caseunitid = unit.unitid
 INNER JOIN idq_production_eks.translation_int_unit ON unit.shortdescid = translation_int_unit.translationid
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter ON (stmara_eks_item.znegotiatingcountry = 'US' AND
       translation_int_unit.description = 'in' AND eks_zsm_articleparameter.id = 'RPTDQ025i' OR (stmara_eks_item.znegotiatingcountry
         <> 'US' OR translation_int_unit.description <> 'in') AND eks_zsm_articleparameter.id = 'RPTDQ025') AND
   svmara_eks_item_messures_diff_betw_articles010.volume > eks_zsm_articleparameter.value
 INNER JOIN idq_production_eks.supplier ON eks.supplierno = supplier.supplierno
 INNER JOIN idq_production_eks.listingoverview ON eks.listingoverviewid = listingoverview.listingoverviewid
 INNER JOIN idq_production_eks.contractlink ON listingoverview.listingoverviewid = contractlink.listingoverviewid
 LEFT JOIN idq_production_eks.loheading AS lh ON listingoverview.loheadingid = lh.loheadingid
 LEFT JOIN idq_production_eks.locategory AS lc ON listingoverview.locategoryid = lc.locategoryid
 LEFT JOIN idq_production_eks.translation_int AS tr_lc ON lc.descriptionid = tr_lc.translationid
 LEFT JOIN idq_production_eks.translation_int AS tr_lh ON lh.descriptionid = tr_lh.translationid
 LEFT JOIN idq_production_eks.contractsignvalue AS csv ON contractlink.contractlinkid = csv.contractlinkid AND csv.signspecid
    = 1
 LEFT JOIN idq_production_eks.signspecval AS sp ON csv.signspecvalid = sp.signspecvalid
 LEFT JOIN idq_production_eks.translation_int AS tr_sp ON sp.descriptionid = tr_sp.translationid
 LEFT JOIN idq_production_eks.validity AS vl ON contractpricevalidity.validityid = vl.validityid
 LEFT JOIN idq_production_eks.translation_int AS tr_vl ON vl.descriptionid = tr_vl.translationid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist ON stmara_eks_item.itemno = eks_zsm_excludelist.itemno AND
    (supplier.intsupplierno = eks_zsm_excludelist.supplierno AND eks_zsm_excludelist.listingoverviewid IS NULL OR eks.listingoverviewid
          = eks_zsm_excludelist.listingoverviewid AND eks_zsm_excludelist.supplierno IS NULL OR supplier.intsupplierno =
        eks_zsm_excludelist.supplierno AND eks.listingoverviewid = eks_zsm_excludelist.listingoverviewid OR
      eks_zsm_excludelist.supplierno IS NULL AND eks_zsm_excludelist.listingoverviewid IS NULL) AND eks_zsm_excludelist
   .reportno = '025'
WHERE CASE
   WHEN LOWER(IFNULL(tr_lc.description, 'x')) LIKE '%display%'
   THEN 1
   WHEN LOWER(IFNULL(tr_lh.description, 'x')) LIKE '%display%'
   THEN 1
   WHEN LOWER(IFNULL(tr_sp.description, 'x')) LIKE '%display%'
   THEN 1
   WHEN LOWER(IFNULL(tr_vl.description, 'x')) LIKE '%palette%'
   THEN 1
   ELSE 0
   END = 0
 AND eks_zsm_excludelist.itemno IS NULL;