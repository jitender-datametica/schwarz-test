CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_kaufland_retail_pmr_prc_overflows (idq_addinfo_kaufland_retail_pmr_id
, idq_test_object_id, ref_branch_id, source_system_primary_key, ref_source_system_id, ref_country_id, is_relevant, matnr
, lifnr, infnr, ekorg, werks, datab, datbi, sperr, loevm) AS SELECT id AS
 idq_addinfo_kaufland_retail_pmr_prc_overflows_id,
 dependent_test_object_id AS idq_test_object_id,
 branch_id AS ref_branch_id,
 source_system_primary_key,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 is_relevant,
 matnr,
 lifnr,
 infnr,
 ekorg,
 werks,
 datab AS datbi,
 datbi AS datbi0,
 sperr,
 loevm
FROM idq_production_idq_results.idq_addinfo_kaufland_retail_pmr_prc_overflows;