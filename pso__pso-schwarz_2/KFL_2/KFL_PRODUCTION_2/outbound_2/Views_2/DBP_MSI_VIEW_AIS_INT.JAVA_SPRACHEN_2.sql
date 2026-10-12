CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_sprachen_2 (spr_id, spr_name, spr_iso) AS SELECT spr_id,
 spr_name,
 spr_iso
FROM kfl_production_dbp_view.v_spr_2
WHERE dwh_spr = 1;