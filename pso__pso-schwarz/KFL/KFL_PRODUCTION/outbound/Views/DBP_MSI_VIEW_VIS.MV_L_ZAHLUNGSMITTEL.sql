CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_zahlungsmittel (mandant_id, zahlungsmittel_id) AS SELECT
 mandant_id,
 zahlungsmittel_id
FROM kfl_production_dbp_v_ods.v_l_zahlungsmittel;