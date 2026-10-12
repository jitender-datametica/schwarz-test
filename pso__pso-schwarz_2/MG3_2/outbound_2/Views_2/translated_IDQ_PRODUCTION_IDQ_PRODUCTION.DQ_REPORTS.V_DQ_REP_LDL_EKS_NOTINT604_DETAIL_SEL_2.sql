CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_rep_ldl_eks_notint604_detail_sel_2 (ref_calculation_time,
ref_country_id, negotiatingcountry, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno
, articletype, description, wstaw, supplierno, supplierdescription, zrelevantmdm, zsource, zactive) AS SELECT
 idq_production_eks_calculation.getlastexecutiontime() AS ref_calculation_time,
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
 wstaw,
 supplierno,
 supplierdescription,
 zrelevantmdm,
 zsource,
 zactive
FROM idq_production_eks_calculation.tvmaw1_dq_eks_wstaw_notint604_detail_sel_2;