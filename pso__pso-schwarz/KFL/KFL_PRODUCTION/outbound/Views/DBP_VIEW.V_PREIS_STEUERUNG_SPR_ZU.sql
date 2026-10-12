CREATE OR REPLACE VIEW kfl_production_dbp_view.v_preis_steuerung_spr_zu AS SELECT preis_steuer_kz,
 mandant_id,
 spr_id,
 preis_steuerung_bez
FROM kfl_production_dbp_data.preis_steuerung_spr_zu;