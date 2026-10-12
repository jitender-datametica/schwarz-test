CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_preis_steuerung_spr_zu_pl (mandant_id, preis_steuer_kz, spr_id
, preis_steuerung_bez) AS SELECT mandant_id,
 preis_steuer_kz,
 spr_id,
 preis_steuerung_bez
FROM kfl_production_dbp_view.v_preis_steuerung_spr_zu
WHERE spr_id = 90;