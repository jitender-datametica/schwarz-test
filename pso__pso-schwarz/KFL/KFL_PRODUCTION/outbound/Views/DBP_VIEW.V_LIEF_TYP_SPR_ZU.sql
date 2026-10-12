CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lief_typ_spr_zu AS SELECT mandant_id,
 lief_typ_id,
 spr_id,
 lief_typ_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lief_typ_spr_zu;