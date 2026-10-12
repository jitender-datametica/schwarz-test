CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_owg_spr_zu AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 owg_bez,
 spr_id
FROM kfl_production_dbp_view.v_owg_spr_zu AS V01
WHERE mandant_id > 1;