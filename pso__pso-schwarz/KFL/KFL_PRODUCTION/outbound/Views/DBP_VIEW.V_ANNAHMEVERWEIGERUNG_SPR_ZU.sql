CREATE OR REPLACE VIEW kfl_production_dbp_view.v_annahmeverweigerung_spr_zu AS SELECT mandant_id,
 annahmeverweigerung_id,
 spr_id,
 annahmeverweigerung_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.annahmeverweigerung_spr_zu;