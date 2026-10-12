CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belegklasse_gruppe_spr_zu AS SELECT belegklasse_gruppe_id,
 mandant_id,
 system_id,
 spr_id,
 belegklasse_gruppe_bez
FROM kfl_production_dbp_data.belegklasse_gruppe_spr_zu;