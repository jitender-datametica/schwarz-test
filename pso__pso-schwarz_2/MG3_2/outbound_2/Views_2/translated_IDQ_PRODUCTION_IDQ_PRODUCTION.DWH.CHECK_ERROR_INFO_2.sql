CREATE OR REPLACE VIEW idq_production_dwh.check_error_info_2 (check_error_info_id, check_test_result_id,
idq_test_object_id, ref_rule_id, invalid_content, additional_info, additional_info_de, additional_info_en,
ref_source_system_type_id, ref_source_system_id, ref_field_id, ref_branch_id, ref_country_id, ref_test_object_type_id,
nat_supplier, int_supplier, gueltig_bis, neg_country, supplier_2, werknr, ps_sap_nr, standort, einkaeufer, lue,
lue_gueltig_bis) AS SELECT ROW_NUMBER() OVER (ORDER BY cer.test_object_id IS NULL, cer.test_object_id) AS
 check_error_info_id,
   10000 * CAST(ctr.test_object_id AS BIGNUMERIC) + ctr.rule_id AS check_test_result_id,
 cer.test_object_id AS idq_test_object_id,
 cer.rule_id AS ref_rule_id,
 cer.invalid_content,
 cer.additional_info_de AS additional_info,
 cer.additional_info_de,
 cer.additional_info_en,
 srs.source_system_type_id AS ref_source_system_type_id,
 ito.source_system_id AS ref_source_system_id,
 rr.field_id AS ref_field_id,
 ito.branch_id AS ref_branch_id,
 ito.country_id AS ref_country_id,
 ito.test_object_type_id AS ref_test_object_type_id,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '|')[SAFE_OFFSET(0)], '')
  ELSE NULL
  END AS nat_supplier,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '|')[SAFE_OFFSET(1)], '')
  ELSE NULL
  END AS int_supplier,
 SUBSTR(CASE
   WHEN cer.additional_info_de IS NOT NULL
   THEN IFNULL(SPLIT(cer.additional_info_de, '|')[SAFE_OFFSET(2)], '')
   ELSE NULL
   END, 0, 19) AS gueltig_bis,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '|')[SAFE_OFFSET(3)], '')
  ELSE NULL
  END AS neg_country,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '|')[SAFE_OFFSET(4)], '')
  ELSE NULL
  END AS supplier_2,
 SUBSTR(cer.additional_info_de, 6, 4) AS werknr,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '#')[SAFE_OFFSET(0)], '')
  ELSE NULL
  END AS ps_sap_nr,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '#')[SAFE_OFFSET(1)], '')
  ELSE NULL
  END AS standort,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '#')[SAFE_OFFSET(2)], '')
  ELSE NULL
  END AS einkaeufer,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '#')[SAFE_OFFSET(3)], '')
  ELSE NULL
  END AS lue,
  CASE
  WHEN cer.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(cer.additional_info_de, '#')[SAFE_OFFSET(4)], '')
  ELSE NULL
  END AS lue_gueltig_bis
FROM idq_production_idq_results.check_error_info_current_2 AS cer
 INNER JOIN idq_production_idq_results.check_test_result_current_2 AS ctr ON cer.test_object_id = ctr.test_object_id AND
   cer.rule_id = ctr.rule_id
 INNER JOIN idq_production_idq_results.idq_test_object_2 AS ito ON cer.test_object_id = ito.id
 INNER JOIN idq_production_idq_results.ref_source_system_2 AS srs ON ito.source_system_id = srs.id
 INNER JOIN idq_production_idq_results.ref_rule_2 AS rr ON cer.rule_id = rr.id;