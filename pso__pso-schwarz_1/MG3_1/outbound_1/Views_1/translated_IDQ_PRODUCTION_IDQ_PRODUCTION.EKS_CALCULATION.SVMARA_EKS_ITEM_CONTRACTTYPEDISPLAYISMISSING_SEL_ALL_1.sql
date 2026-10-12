CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_contracttypedisplayismissing_sel_all_1 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
contractdesc, luheadline, articleheadline, contractheadline, listingoverviewid, receivingcountry, supplierno,
supplierdescription, ba_number, ba_description, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT CASE
  WHEN st.znegotiatingcountry = 'NT'
  THEN 'INTEGER'
  ELSE st.znegotiatingcountry
  END AS negotiatingcountry,
 st.buyershortsign,
 st.buyerfirstname,
 st.buyerlastname,
 st.zmatkl,
 st.articlefamily,
 st.itemid,
 st.itemno,
 st.zarticletype AS articletype,
 st.description_int AS description,
 tr_lc.description AS contractdesc,
 tr_lh.description AS luheadline,
 tr_val.description AS articleheadline,
 tr_sp.description AS contractheadline,
 xt.listingoverviewid,
 xt.receivingcountry,
 supp.intsupplierno AS supplierno,
 supp.shortdesc AS supplierdescription,
 st_ba.itemno AS ba_number,
 st_ba.description_int AS ba_description,
 st.zrelevantmdm,
 st.zsource,
 st.zactive
FROM idq_production_eks_calculation.stmara_eks_item_1 AS st
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1 AS xt ON CASE
   WHEN xt.sk_itemid IS NULL
   THEN xt.itemid
   ELSE xt.sk_itemid
   END = st.itemid
 LEFT JOIN idq_production_eks.contractpricevalidity_1 ON xt.contractpricevalidityid = contractpricevalidity.contractpricevalidityid
  
 LEFT JOIN idq_production_eks.validity_1 AS val ON contractpricevalidity.validityid = val.validityid
 LEFT JOIN idq_production_eks.translation_int_1 AS tr_val ON val.descriptionid = tr_val.translationid
 LEFT JOIN idq_production_eks.listingoverview_1 AS list ON xt.listingoverviewid = list.listingoverviewid
 LEFT JOIN idq_production_eks.locategory_1 AS lc ON list.locategoryid = lc.locategoryid
 LEFT JOIN idq_production_eks.translation_int_1 AS tr_lc ON lc.descriptionid = tr_lc.translationid
 LEFT JOIN idq_production_eks.loheading_1 AS lh ON list.loheadingid = lh.loheadingid
 LEFT JOIN idq_production_eks.translation_int_1 AS tr_lh ON lh.descriptionid = tr_lh.translationid
 LEFT JOIN idq_production_eks.contractsignvalue_1 AS csv ON xt.contractlinkid = csv.contractlinkid AND csv.signspecid = 1
 LEFT JOIN idq_production_eks.signspecval_1 AS sp ON csv.signspecvalid = sp.signspecvalid
 LEFT JOIN idq_production_eks.translation_int_1 AS tr_sp ON sp.descriptionid = tr_sp.translationid
 LEFT JOIN idq_production_eks.supplier_1 AS supp ON xt.supplierno = supp.supplierno
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item_1 AS st_ba ON st.zitem_ba = st_ba.itemid
WHERE LOWER(st.description_int) LIKE '%display%' AND (LOWER(tr_lc.description) NOT LIKE '%display%' OR LOWER(tr_lh.description
      ) NOT LIKE '%display%')
 OR LOWER(tr_lh.description) LIKE '%display%' AND LOWER(tr_lc.description) NOT LIKE '%display%'
 OR LOWER(tr_lc.description) LIKE '%display%' AND LOWER(tr_lh.description) NOT LIKE '%display%'
 OR (LOWER(tr_lc.description) NOT LIKE '%display%' OR LOWER(tr_lh.description) NOT LIKE '%display%') AND LOWER(tr_val.description
    ) LIKE '%display%'
 OR (LOWER(tr_lc.description) NOT LIKE '%display%' OR LOWER(tr_lh.description) NOT LIKE '%display%') AND LOWER(tr_sp.description
    ) LIKE '%display%';