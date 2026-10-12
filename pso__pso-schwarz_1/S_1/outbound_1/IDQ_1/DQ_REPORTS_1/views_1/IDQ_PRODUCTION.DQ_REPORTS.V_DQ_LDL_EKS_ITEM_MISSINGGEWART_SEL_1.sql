CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_ldl_eks_item_missinggewart_sel_1 (ref_calculation_time,
ref_country_id, negotiatingcountry, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno
, articletype, description, text_nat, zrelevantmdm, zsource, zactive) AS SELECT idq_production_eks_calculation.getlastexecutiontime() AS
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
 text_nat,
 zrelevantmdm,
 zsource,
 zactive
FROM idq_production_eks_calculation.svmara_eks_item_dq_eks_missinggewart_sel_1;