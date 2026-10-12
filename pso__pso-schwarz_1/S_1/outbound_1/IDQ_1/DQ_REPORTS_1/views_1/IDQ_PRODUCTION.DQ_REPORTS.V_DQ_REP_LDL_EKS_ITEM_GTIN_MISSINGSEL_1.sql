CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_rep_ldl_eks_item_gtin_missingsel_1 (ref_calculation_time,
ref_country_id, negotiatingcountry, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno
, articletype, description, supplierno, supplierdescription, listingoverviewid, receivingcountry, zusatz, itemvalidfrom
, itemvaliduntil, zrelevantmdm, suppliercountry, zsource, zactive) AS SELECT idq_production_eks_calculation.getlastexecutiontime() AS
 ref_calculation_time,
 idq_production_dq_reports.getcountryid_ltlv_workaround(negotiatingcountry, itemno) AS ref_country_id,
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
 supplierno,
 supplierdescription,
 listingoverviewid,
 receivingcountry,
 zusatz,
 itemvalidfrom,
 itemvaliduntil,
 zrelevantmdm,
 suppliercountry,
 zsource,
 zactive
FROM idq_production_eks_calculation.svmara_eks_item_gtin_missingsel_1;