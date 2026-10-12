CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_abt_spr_zu_1 AS SELECT mandant_id,
 abt_id,
 arthiertyp_id,
 abt_bez,
 spr_id
FROM kfl_production_dbp_view.v_abt_spr_zu_1 AS V01
WHERE mandant_id <> 1
 AND arthiertyp_id = 2;