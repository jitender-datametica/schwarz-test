CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_ldl_eks__missingkolligtin_sel_no_country_id_2 (ref_calculation_time
, negotiatingcountry, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype
, description, decimalcasesize, kolligtin, listingoverviewid, supplierno, supplierdescription, zrelevantmdm, zsource,
zactive) AS SELECT idq_production_eks_calculation.getlastexecutiontime() AS ref_calculation_time,
 negotiatingcountry,
 buyershortsign,
 buyerfirstname,
 buyerlastname,
 zmatkl,
 articlefamily,
 itemid,
 itemno,
 articletype,
 description,
 decimalcasesize,
 kolligtin,
 listingoverviewid,
 supplierno,
 supplierdescription,
 zrelevantmdm,
 zsource,
 zactive
FROM idq_production_eks_calculation.svmara_eks_item_dq_eks_missingkolligtin_sel_2;