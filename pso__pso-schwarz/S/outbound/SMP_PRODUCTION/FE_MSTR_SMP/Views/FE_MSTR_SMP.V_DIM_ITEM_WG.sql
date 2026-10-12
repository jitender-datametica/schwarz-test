CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_item_wg (division_id, country_id, wg_id, wg_desc) AS SELECT
DISTINCT division_id,
 country_id,
 taxonomy_id AS wg_id,
 taxonomy_name AS wg_desc
FROM smp_production_core_rel.t_taxonomy_hierarchy
WHERE level = 4;