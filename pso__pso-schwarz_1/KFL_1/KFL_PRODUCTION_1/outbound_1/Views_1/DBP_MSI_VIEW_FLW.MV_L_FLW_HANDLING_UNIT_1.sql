CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_handling_unit_1 (mandant_id, handling_unit_id, in_kunde_id
, handling_unit_id_ext, ntvol_ladung, brtvol_ladung, ntgew_ladung, brtgew_ladung, hu_voleinh_id, hu_geweinh_id) AS
SELECT mandant_id,
 handling_unit_id,
 flw_kunde_id AS in_kunde_id,
 handling_unit_id_ext,
 ntvol_ladung,
 brtvol_ladung,
 ntgew_ladung,
 brtgew_ladung,
 hu_voleinh_id,
 hu_geweinh_id
FROM kfl_production_dbp_view.v_flw_handling_unit_1;