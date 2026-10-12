CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bestaetigung_typ_spr_zu AS SELECT mandant_id,
 bestaetigung_typ_id,
 spr_id,
 bestaetigung_typ_bez
FROM kfl_production_dbp_data.bestaetigung_typ_spr_zu;