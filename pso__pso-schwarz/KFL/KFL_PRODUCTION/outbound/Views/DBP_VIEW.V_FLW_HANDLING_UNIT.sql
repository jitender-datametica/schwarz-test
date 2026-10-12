CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_handling_unit AS SELECT mandant_id,
 handling_unit_id,
 flw_kunde_id,
 handling_unit_id_ext,
 ntvol_ladung,
 brtvol_ladung,
 ntgew_ladung,
 brtgew_ladung,
 hu_voleinh_id,
 hu_geweinh_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_handling_unit;