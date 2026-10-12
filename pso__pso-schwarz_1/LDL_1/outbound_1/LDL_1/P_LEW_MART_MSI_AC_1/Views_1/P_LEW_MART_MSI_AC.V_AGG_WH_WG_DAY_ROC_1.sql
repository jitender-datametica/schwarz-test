/* #----------------------------------------------------------------------------
# History:
#  1.0  18.07.2022    Oliver Haus         Initial DDL deployment - RWL aggregated values for Cockpits
#  1.1  10.07.2023    Chetana Patil       Added logic for RWL_WEIGHTED_VJ  
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_wh_wg_day_roc_1 (client_id, gl_region_id, wh_id, itemgroup_int_id,
dat_formdate, currency_iso_cd, qty_piece_stc_wh, rwl_nominator, rwl_weighted, rwl_weighted_vj) AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_wh_wg_day_roc_1;