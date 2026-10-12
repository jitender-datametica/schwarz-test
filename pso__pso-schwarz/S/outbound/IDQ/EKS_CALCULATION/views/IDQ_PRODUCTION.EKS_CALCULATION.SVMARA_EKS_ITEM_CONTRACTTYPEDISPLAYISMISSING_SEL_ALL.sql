CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_contracttypedisplayismissing_sel_all (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
contractdesc, luheadline, articleheadline, contractheadline, listingoverviewid, receivingcountry, supplierno,
supplierdescription, ba_number, ba_description, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT CASE
  WHEN ST.znegotiatingcountry = 'NT'
  THEN 'INTEGER '
  ELSE ST.znegotiatingcountry
  END AS negotiatingcountry,
 ST.buyershortsign,
 ST.buyerfirstname,
 ST.buyerlastname,
 ST.zmatkl,
 ST.articlefamily,
 ST.itemid,
 ST.itemno,
 ST.zarticletype AS articletype,
 ST.description_int AS description,
 TR_LC.description AS contractdesc,
 TR_LH.description AS luheadline,
 TR_VAL.description AS articleheadline,
 TR_SP.description AS contractheadline,
 XT.listingoverviewid,
 XT.receivingcountry,
 SUPP.intsupplierno AS supplierno,
 SUPP.shortdesc AS supplierdescription,
 ST_BA.itemno AS ba_number,
 ST_BA.description_int AS ba_description,
 ST.zrelevantmdm,
 ST.zsource,
 ST.zactive
FROM idq_production_eks_calculation.stmara_eks_item AS ST
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry AS XT ON CASE
   WHEN XT.sk_itemid IS NULL
   THEN XT.itemid
   ELSE XT.sk_itemid
   END = ST.itemid
 LEFT JOIN idq_production_eks.contractpricevalidity ON XT.contractpricevalidityid = contractpricevalidity.contractpricevalidityid
  
 LEFT JOIN idq_production_eks.validity AS VAL ON contractpricevalidity.validityid = VAL.validityid
 LEFT JOIN idq_production_eks.translation_int AS TR_VAL ON VAL.descriptionid = TR_VAL.translationid
 LEFT JOIN idq_production_eks.listingoverview AS LIST ON XT.listingoverviewid = LIST.listingoverviewid
 LEFT JOIN idq_production_eks.locategory AS LC ON LIST.locategoryid = LC.locategoryid
 LEFT JOIN idq_production_eks.translation_int AS TR_LC ON LC.descriptionid = TR_LC.translationid
 LEFT JOIN idq_production_eks.loheading AS LH ON LIST.loheadingid = LH.loheadingid
 LEFT JOIN idq_production_eks.translation_int AS TR_LH ON LH.descriptionid = TR_LH.translationid
 LEFT JOIN idq_production_eks.contractsignvalue AS CSV ON XT.contractlinkid = CSV.contractlinkid AND CSV.signspecid = 1
 LEFT JOIN idq_production_eks.signspecval AS SP ON CSV.signspecvalid = SP.signspecvalid
 LEFT JOIN idq_production_eks.translation_int AS TR_SP ON SP.descriptionid = TR_SP.translationid
 LEFT JOIN idq_production_eks.supplier AS SUPP ON XT.supplierno = SUPP.supplierno
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item AS ST_BA ON ST.zitem_ba = ST_BA.itemid
WHERE LOWER(ST.description_int) LIKE '%display%' AND (LOWER(TR_LC.description) NOT LIKE '%display%' OR LOWER(TR_LH.description
      ) NOT LIKE '%display%')
 OR LOWER(TR_LH.description) LIKE '%display%' AND LOWER(TR_LC.description) NOT LIKE '%display%'
 OR LOWER(TR_LC.description) LIKE '%display%' AND LOWER(TR_LH.description) NOT LIKE '%display%'
 OR (LOWER(TR_LC.description) NOT LIKE '%display%' OR LOWER(TR_LH.description) NOT LIKE '%display%') AND LOWER(TR_VAL.description
    ) LIKE '%display%'
 OR (LOWER(TR_LC.description) NOT LIKE '%display%' OR LOWER(TR_LH.description) NOT LIKE '%display%') AND LOWER(TR_SP.description
    ) LIKE '%display%';