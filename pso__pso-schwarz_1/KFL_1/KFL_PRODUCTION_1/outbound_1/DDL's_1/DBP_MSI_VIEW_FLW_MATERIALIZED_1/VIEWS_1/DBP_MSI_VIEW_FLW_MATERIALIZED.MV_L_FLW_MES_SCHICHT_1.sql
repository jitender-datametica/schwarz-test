CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_mes_schicht_1 (mandant_id, schicht_id,
schichttyp_id, dat_schicht, flw_arbeitsplatz_id) AS SELECT mandant_id,
 schicht_id,
 schichttyp_id,
 dat_schicht,
 flw_arbeitsplatz_id
FROM kfl_production_dbp_view.v_flw_mes_schicht_1;