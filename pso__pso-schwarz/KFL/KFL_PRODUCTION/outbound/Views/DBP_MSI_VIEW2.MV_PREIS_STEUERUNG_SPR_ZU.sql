CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_preis_steuerung_spr_zu (preis_steuer_kz, mandant_id, spr_id,
preis_steuerung_bez) AS SELECT preis_steuer_kz,
 mandant_id,
 spr_id,
 preis_steuerung_bez
FROM kfl_production_dbp_view.v_preis_steuerung_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;