CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_preis_steuerung_1 (mandant_id, preis_steuer_kz) AS SELECT
 mandant_id,
 preis_steuer_kz
FROM kfl_production_dbp_view.v_l_preis_steuerung_1;