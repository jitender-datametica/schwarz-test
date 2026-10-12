CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_syscomp_wawi_zsm_item_2 (id, leading_idq_test_object_id,
leading_primary_key, dependent_primary_key, leading_system_id, dependent_system_id, branch_id, country_id, int_artikelnr
, artikelnr, deutschtext, wb, artgrupnr, itemfamily_id) AS SELECT ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY 1 IS NULL,
    1) AS id,
 b.id AS leading_idq_test_object_id,
 a.leading_primary_key,
 a.dependent_primary_key,
 a.leading_system_id,
 a.dependent_system_id,
 a.branch_id,
 a.country_id,
 a.int_artikelnr,
 a.artikelnr,
 a.deutschtext,
 a.wb,
 a.artgrupnr,
 a.itemfamily_id
FROM idq_production_idq_results.idq_addinfo_syscomp_wawi_zsm_item_2 AS a
 LEFT JOIN (SELECT id,
   source_system_primary_key,
   country_id
  FROM idq_production_idq_results.idq_test_object_2
  WHERE source_system_id IN (SELECT a0.id
     FROM idq_production_idq_results.ref_source_system_2 AS a0
      LEFT JOIN idq_production_idq_results.ref_source_system_type_2 AS b ON a0.source_system_type_id = b.id
     WHERE b.id = 2
      AND a0.source_system NOT LIKE '%WH%')
   AND test_object_type_id = 1) AS b ON a.leading_primary_key = b.source_system_primary_key AND a.country_id = b.country_id;