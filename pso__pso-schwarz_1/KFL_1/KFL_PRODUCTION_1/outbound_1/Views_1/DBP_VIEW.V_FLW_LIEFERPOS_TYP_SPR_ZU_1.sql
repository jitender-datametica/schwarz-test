CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_lieferpos_typ_spr_zu_1 AS SELECT mandant_id,
 lief_pos_typ_id,
 spr_id,
 lief_pos_typ_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_lieferpos_typ_spr_zu_1;