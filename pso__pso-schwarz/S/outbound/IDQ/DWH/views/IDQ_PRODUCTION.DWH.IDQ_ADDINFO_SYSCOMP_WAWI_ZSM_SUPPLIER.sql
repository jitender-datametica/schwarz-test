CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_syscomp_wawi_zsm_supplier (id, leading_idq_test_object_id,
leading_primary_key, dependent_primary_key, leading_system_id, dependent_system_id, branch_id, country_id,
c216_int_suppnr, wawi_name, int_buy_country, c0606_reason_for_relevance, zsm_name, warenbereiche, suchname,
sap_kred_link) AS SELECT ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY 1 IS NULL, 1) AS id,
 b.id AS leading_idq_test_object_id,
 A.leading_primary_key,
 A.dependent_primary_key,
 A.leading_system_id,
 A.dependent_system_id,
 A.branch_id,
 A.country_id,
 A.c216_int_suppnr,
 A.wawi_name,
 A.int_buy_country,
 A.c0606_reason_for_relevance,
 A.zsm_name,
 A.warenbereiche,
 A.suchname,
 A.sap_kred_link
FROM idq_production_idq_results.idq_addinfo_syscomp_wawi_zsm_supplier AS A
 LEFT JOIN (SELECT id,
   source_system_primary_key,
   country_id
  FROM idq_production_idq_results.idq_test_object
  WHERE source_system_id IN (SELECT A0.id
     FROM idq_production_idq_results.ref_source_system AS A0
      LEFT JOIN idq_production_idq_results.ref_source_system_type AS B ON A0.source_system_type_id = B.id
     WHERE B.id = 2
      AND A0.source_system NOT LIKE '%WH%')
   AND test_object_type_id = 2) AS b ON A.leading_primary_key = b.source_system_primary_key AND A.country_id = b.country_id;