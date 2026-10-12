CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wbs_zeitslots_aenderung AS SELECT mandant_id,
 auslieferungsgruppe_id,
 dat,
 zeitslot_id
FROM kfl_production_dbp_msi_data.ts_wbs_zeitslots_aenderung;