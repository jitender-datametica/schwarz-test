CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_wawi_lief_1 (idq_addinfo_wawi_lief_id, idq_test_object_id,
ref_branch_id, source_system_primary_key, ref_source_system_id, ref_country_id, krednr, c216_int_suppnr, name1, suchname
, umsatz_id, int_buy_country, gln, c0606_reason_for_relevance, is_relevant) AS SELECT id AS idq_addinfo_wawi_lief_id,
 test_object_id AS idq_test_object_id,
 branch_id AS ref_branch_id,
 source_system_primary_key,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 krednr,
 c216_int_suppnr,
 name1,
 suchname,
 umsatz_id,
 int_buy_country,
 gln,
 c0606_reason_for_relevance,
 is_relevant
FROM idq_production_idq_results.idq_addinfo_wawi_lief_1;