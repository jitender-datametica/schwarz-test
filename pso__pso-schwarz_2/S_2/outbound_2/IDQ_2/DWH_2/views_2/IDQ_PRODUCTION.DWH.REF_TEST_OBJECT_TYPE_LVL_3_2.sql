CREATE OR REPLACE VIEW idq_production_dwh.ref_test_object_type_lvl_3_2 (ref_test_object_type_level_3_id, is_dummy,
test_object_type, test_object_type_extended_name, test_object_type_extended_name_de, test_object_type_extended_name_en,
test_object_type_extended_sorting_order, test_object_type_extended_change_by, test_object_type_extended_last_change,
test_object_type_extended_from_date, test_object_type_extended_to_date, ref_test_object_type_level_2_id) AS SELECT id AS
 ref_test_object_type_level_3_id,
  CASE
  WHEN level_3_id IS NULL
  THEN 1
  ELSE 0
  END AS is_dummy,
 test_object_type,
 name_de AS test_object_type_extended_name,
 name_de AS test_object_type_extended_name_de,
 name_en AS test_object_type_extended_name_en,
 sorting_order AS test_object_type_extended_sorting_order,
 change_by AS test_object_type_extended_change_by,
 last_change AS test_object_type_extended_last_change,
 from_date AS test_object_type_extended_from_date,
 to_date AS test_object_type_extended_to_date,
  CASE
  WHEN id = level_1_id
  THEN id
  ELSE level_2_id
  END AS ref_test_object_type_level_2_id
FROM idq_production_idq_results.ref_test_object_type_extended_2 AS TOTE;