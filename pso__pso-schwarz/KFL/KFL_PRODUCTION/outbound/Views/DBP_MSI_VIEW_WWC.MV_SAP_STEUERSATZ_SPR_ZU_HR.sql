CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_sap_steuersatz_spr_zu_hr AS SELECT steuer_typ_id,
 sap_steuer_id,
 mandant_id,
 sap_steuer_bez
FROM kfl_production_dbp_view.v_sap_steuersatz_spr_zu
WHERE spr_id = 65;