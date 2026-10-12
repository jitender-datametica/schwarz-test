CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_wup_2 (mandant_id, aktuell_wup_id, wup_standort) AS SELECT
 mandant_id,
 wup_id AS aktuell_wup_id,
 MAX(projekt_standort_name) AS wup_standort
FROM kfl_production_dbp_msi_data.zb_dim_projekt_2
GROUP BY mandant_id,
 aktuell_wup_id;