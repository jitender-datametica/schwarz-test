CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_with_measure_gt_cm_sel_1 (negotiatingcountry,
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
FROM idq_production_eks_calculation.stmara_eks_item_1
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
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1
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
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1
   WHERE sk_itemid IS NOT NULL) AS eks ON stmara_eks_item.itemid = eks.itemid
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_messures_diff_betw_articles010_1 ON eks.itemid =
     svmara_eks_item_messures_diff_betw_articles010.itemid AND eks.listingoverviewid =
     svmara_eks_item_messures_diff_betw_articles010.listingoverviewid AND eks.casesize =
    svmara_eks_item_messures_diff_betw_articles010.casesize AND eks.receivingcountry =
   svmara_eks_item_messures_diff_betw_articles010.receivingcountry
 INNER JOIN idq_production_eks.contractpricevalidity_1 ON eks.contractpricevalidityid = contractpricevalidity.contractpricevalidityid
  
 INNER JOIN idq_production_eks.itemdimension_1 ON eks.contractpricevalidityid = itemdimension.contractpricevalidityid AND
   stmara_eks_item.itemid = itemdimension.itemid
 INNER JOIN idq_production_eks.unit_1 ON itemdimension.caseunitid = unit.unitid
 INNER JOIN idq_production_eks.translation_int_unit_1 ON unit.shortdescid = translation_int_unit.translationid
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_1 ON (stmara_eks_item.znegotiatingcountry = 'US' AND
       translation_int_unit.description = 'in' AND eks_zsm_articleparameter.id = 'RPTDQ025i' OR (stmara_eks_item.znegotiatingcountry
         <> 'US' OR translation_int_unit.description <> 'in') AND eks_zsm_articleparameter.id = 'RPTDQ025') AND
   svmara_eks_item_messures_diff_betw_articles010.volume > eks_zsm_articleparameter.value
 INNER JOIN idq_production_eks.supplier_1 ON eks.supplierno = supplier.supplierno
 INNER JOIN idq_production_eks.listingoverview_1 ON eks.listingoverviewid = listingoverview.listingoverviewid
 INNER JOIN idq_production_eks.contractlink_1 ON listingoverview.listingoverviewid = contractlink.listingoverviewid
 LEFT JOIN idq_production_eks.loheading_1 AS LH ON listingoverview.loheadingid = LH.loheadingid
 LEFT JOIN idq_production_eks.locategory_1 AS LC ON listingoverview.locategoryid = LC.locategoryid
 LEFT JOIN idq_production_eks.translation_int_1 AS TR_LC ON LC.descriptionid = TR_LC.translationid
 LEFT JOIN idq_production_eks.translation_int_1 AS TR_LH ON LH.descriptionid = TR_LH.translationid
 LEFT JOIN idq_production_eks.contractsignvalue_1 AS CSV ON contractlink.contractlinkid = CSV.contractlinkid AND CSV.signspecid
    = 1
 LEFT JOIN idq_production_eks.signspecval_1 AS SP ON CSV.signspecvalid = SP.signspecvalid
 LEFT JOIN idq_production_eks.translation_int_1 AS TR_SP ON SP.descriptionid = TR_SP.translationid
 LEFT JOIN idq_production_eks.validity_1 AS VL ON contractpricevalidity.validityid = VL.validityid
 LEFT JOIN idq_production_eks.translation_int_1 AS TR_VL ON VL.descriptionid = TR_VL.translationid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist_1 ON stmara_eks_item.itemno = eks_zsm_excludelist.itemno AND
    (supplier.intsupplierno = eks_zsm_excludelist.supplierno AND eks_zsm_excludelist.listingoverviewid IS NULL OR eks.listingoverviewid
          = eks_zsm_excludelist.listingoverviewid AND eks_zsm_excludelist.supplierno IS NULL OR supplier.intsupplierno =
        eks_zsm_excludelist.supplierno AND eks.listingoverviewid = eks_zsm_excludelist.listingoverviewid OR
      eks_zsm_excludelist.supplierno IS NULL AND eks_zsm_excludelist.listingoverviewid IS NULL) AND eks_zsm_excludelist_1
   .reportno = '025'
WHERE CASE
   WHEN LOWER(IFNULL(TR_LC.description, 'x')) LIKE '%display%'
   THEN 1
   WHEN LOWER(IFNULL(TR_LH.description, 'x')) LIKE '%display%'
   THEN 1
   WHEN LOWER(IFNULL(TR_SP.description, 'x')) LIKE '%display%'
   THEN 1
   WHEN LOWER(IFNULL(TR_VL.description, 'x')) LIKE '%palette%'
   THEN 1
   ELSE 0
   END = 0
 AND eks_zsm_excludelist.itemno IS NULL;