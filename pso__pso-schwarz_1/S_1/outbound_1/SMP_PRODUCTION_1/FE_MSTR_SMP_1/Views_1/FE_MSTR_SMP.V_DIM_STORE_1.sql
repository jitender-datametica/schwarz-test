CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_store_1 (division_id, country_id, division_country_ref, store_id,
store_nr, store_id_ref, store_name, region_name) AS SELECT DISTINCT division_id,
 country_id,
 division_country_ref,
 store_id,
 store_nr,
 store_id_ref,
 store_name,
 region_name
FROM smp_production_core_rel.t_store_1;