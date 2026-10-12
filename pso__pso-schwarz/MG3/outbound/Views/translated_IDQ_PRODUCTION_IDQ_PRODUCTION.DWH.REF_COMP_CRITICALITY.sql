CREATE OR REPLACE VIEW idq_production_dwh.ref_comp_criticality (ref_criticality_id, criticality_technical_name, penalty
, sla_in_days, criticality_name, criticality_name_de, criticality_name_en) AS SELECT id AS ref_criticality_id,
 criticality AS criticality_technical_name,
 penalty,
 sla_in_days,
 name_de AS criticality_name,
 name_de AS criticality_name_de,
 name_en AS criticality_name_en
FROM idq_production_idq_results.ref_criticality;