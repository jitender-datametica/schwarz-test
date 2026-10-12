CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_division_2 (division_id, division_name) AS SELECT division_id,
 division_name
FROM smp_production_core_rel.t_division_2;