CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_l_pruefung_typ_1 (amx_system_id, pruefung_typ_id, pruefung_typ_bez)
AS SELECT amx_system_id,
 pruefung_typ_id,
 pruefung_typ_bez
FROM kfl_production_dbp_data.kmr_l_pruefung_typ_1;