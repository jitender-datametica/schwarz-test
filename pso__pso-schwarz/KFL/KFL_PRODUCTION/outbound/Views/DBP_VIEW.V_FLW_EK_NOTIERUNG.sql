CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_ek_notierung AS SELECT flw_art_id,
 mandant_id,
 dat,
 plan_fg,
 system_id,
 pjwo,
 betrag,
 wrg_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_ek_notierung;