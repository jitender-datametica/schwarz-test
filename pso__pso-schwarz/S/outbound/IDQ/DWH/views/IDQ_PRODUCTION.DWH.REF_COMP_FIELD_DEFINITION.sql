CREATE OR REPLACE VIEW idq_production_dwh.ref_comp_field_definition (ref_comp_field_definition_id,
ref_comp_definition_id, leading_field_id, dependent_field_id, ref_criticality_id, ref_field_comp_type_id,
functional_field_name, functional_field_name_de, functional_field_name_en) AS SELECT id AS ref_comp_field_definition_id
 ,
 comp_definition_id AS ref_comp_definition_id,
 leading_field_id,
 dependent_field_id,
 criticality_id AS ref_criticality_id,
 field_comp_type_id AS ref_field_comp_type_id,
 functional_field_name,
 functional_field_name_de,
 functional_field_name_en
FROM idq_production_idq_results.ref_comp_field_definition;