CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_sprachen_1 AS SELECT spr_id,
 spr_name,
 spr_iso
FROM kfl_production_dbp_view.v_spr_1
WHERE dwh_spr = 1;