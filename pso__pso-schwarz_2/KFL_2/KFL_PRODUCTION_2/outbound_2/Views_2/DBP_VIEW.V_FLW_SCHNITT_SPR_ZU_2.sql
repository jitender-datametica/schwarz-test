CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_schnitt_spr_zu_2 AS SELECT schnitt_id,
 sek_schl_typ_id,
 sek_schl_id,
 spr_id,
 mandant_id,
 system_id,
 schnitt_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_schnitt_spr_zu_2;