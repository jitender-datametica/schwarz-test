CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_belegtyp_1 AS SELECT mandant_id,
 flw_beleg_typ_id
FROM kfl_production_dbp_view.v_flw_l_belegtyp_1 AS V01
WHERE mandant_id IN (1, 2);