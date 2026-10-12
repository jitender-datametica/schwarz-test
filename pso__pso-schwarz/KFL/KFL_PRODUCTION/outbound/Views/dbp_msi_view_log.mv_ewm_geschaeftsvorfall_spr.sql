CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ewm_geschaeftsvorfall_spr (ewm_gv_id, mandant_id,
lagernummer_id, ewm_gv_bez, spr_id) AS SELECT ewm_gv_id,
 mandant_id,
 lagernummer_id,
 ewm_gv_bez,
 spr_id
FROM kfl_production_dbp_view.v_ewm_geschaeftsvorfall_spr_zu AS V01;