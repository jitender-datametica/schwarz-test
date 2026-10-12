CREATE OR REPLACE VIEW idq_production_dwh.check_error_info (check_error_info_id, check_test_result_id,
idq_test_object_id, ref_rule_id, invalid_content, additional_info, additional_info_de, additional_info_en,
ref_source_system_type_id, ref_source_system_id, ref_field_id, ref_branch_id, ref_country_id, ref_test_object_type_id,
nat_supplier, int_supplier, gueltig_bis, neg_country, supplier, werknr, ps_sap_nr, standort, einkaeufer, lue,
lue_gueltig_bis) AS SELECT ROW_NUMBER() OVER (ORDER BY CER.test_object_id IS NULL, CER.test_object_id) AS
 check_error_info_id,
   10000 * CAST(CTR.test_object_id AS BIGNUMERIC) + CTR.rule_id AS check_test_result_id,
 CER.test_object_id AS idq_test_object_id,
 CER.rule_id AS ref_rule_id,
 CER.invalid_content,
 CER.additional_info_de AS additional_info,
 CER.additional_info_de,
 CER.additional_info_en,
 SRS.source_system_type_id AS ref_source_system_type_id,
 ITO.source_system_id AS ref_source_system_id,
 RR.field_id AS ref_field_id,
 ITO.branch_id AS ref_branch_id,
 ITO.country_id AS ref_country_id,
 ITO.test_object_type_id AS ref_test_object_type_id,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '|')[SAFE_OFFSET(0)], '')
  ELSE NULL
  END AS nat_supplier,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '|')[SAFE_OFFSET(1)], '')
  ELSE NULL
  END AS int_supplier,
 SUBSTR(CASE
   WHEN CER.additional_info_de IS NOT NULL
   THEN IFNULL(SPLIT(CER.additional_info_de, '|')[SAFE_OFFSET(2)], '')
   ELSE NULL
   END, 0, 19) AS gueltig_bis,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '|')[SAFE_OFFSET(3)], '')
  ELSE NULL
  END AS neg_country,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '|')[SAFE_OFFSET(4)], '')
  ELSE NULL
  END AS supplier,
 SUBSTR(CER.additional_info_de, 6, 4) AS werknr,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '#')[SAFE_OFFSET(0)], '')
  ELSE NULL
  END AS ps_sap_nr,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '#')[SAFE_OFFSET(1)], '')
  ELSE NULL
  END AS standort,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '#')[SAFE_OFFSET(2)], '')
  ELSE NULL
  END AS einkaeufer,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '#')[SAFE_OFFSET(3)], '')
  ELSE NULL
  END AS lue,
  CASE
  WHEN CER.additional_info_de IS NOT NULL
  THEN IFNULL(SPLIT(CER.additional_info_de, '#')[SAFE_OFFSET(4)], '')
  ELSE NULL
  END AS lue_gueltig_bis
FROM idq_production_idq_results.check_error_info_current AS CER
 INNER JOIN idq_production_idq_results.check_test_result_current AS CTR ON CER.test_object_id = CTR.test_object_id AND
   CER.rule_id = CTR.rule_id
 INNER JOIN idq_production_idq_results.idq_test_object AS ITO ON CER.test_object_id = ITO.id
 INNER JOIN idq_production_idq_results.ref_source_system AS SRS ON ITO.source_system_id = SRS.id
 INNER JOIN idq_production_idq_results.ref_rule AS RR ON CER.rule_id = RR.id;