CREATE OR REPLACE VIEW idq_production_dwh.ref_test_object_type (ref_test_object_type_id, test_object_type_technical_name
, parent_id, test_object_type_name, test_object_type_name_de, test_object_type_name_en) AS SELECT id AS
 ref_test_object_type_id,
 test_object_type AS test_object_type_technical_name,
 parent_id,
 name_de AS test_object_type_name,
 name_de AS test_object_type_name_de,
 name_en AS test_object_type_name_en
FROM idq_production_idq_results.ref_test_object_type;