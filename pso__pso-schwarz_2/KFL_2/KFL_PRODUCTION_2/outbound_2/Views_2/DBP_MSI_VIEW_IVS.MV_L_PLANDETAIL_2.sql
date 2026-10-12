CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_plandetail_2 AS SELECT plandetail_id,
 plantyp_id,
 mandant_id,
 plandetail_bez,
 spr_id,
 dat_extrakt
FROM kfl_production_dbp_view.v_ivs_l_plandetail_2
WHERE spr_id = 22;