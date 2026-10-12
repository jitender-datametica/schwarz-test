CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_syscomp_wawi_zsm_supplier (id, leading_idq_test_object_id,
leading_primary_key, dependent_primary_key, leading_system_id, dependent_system_id, branch_id, country_id,
c216_int_suppnr, wawi_name, int_buy_country, c0606_reason_for_relevance, zsm_name, warenbereiche, suchname,
sap_kred_link) AS SELECT ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY 1 IS NULL, 1) AS id,
 b.id AS leading_idq_test_object_id,
 a.leading_primary_key,
 a.dependent_primary_key,
 a.leading_system_id,
 a.dependent_system_id,
 a.branch_id,
 a.country_id,
 a.c216_int_suppnr,
 a.wawi_name,
 a.int_buy_country,
 a.c0606_reason_for_relevance,
 a.zsm_name,
 a.warenbereiche,
 a.suchname,
 a.sap_kred_link
FROM idq_production_idq_results.idq_addinfo_syscomp_wawi_zsm_supplier AS a
 LEFT JOIN (SELECT id,
   source_system_primary_key,
   country_id
  FROM idq_production_idq_results.idq_test_object
  WHERE source_system_id IN (SELECT a0.id
     FROM idq_production_idq_results.ref_source_system AS a0
      LEFT JOIN idq_production_idq_results.ref_source_system_type AS b ON a0.source_system_type_id = b.id
     WHERE b.id = 2
      AND a0.source_system NOT LIKE '%WH%')
   AND test_object_type_id = 2) AS b ON a.leading_primary_key = b.source_system_primary_key AND a.country_id = b.country_id;