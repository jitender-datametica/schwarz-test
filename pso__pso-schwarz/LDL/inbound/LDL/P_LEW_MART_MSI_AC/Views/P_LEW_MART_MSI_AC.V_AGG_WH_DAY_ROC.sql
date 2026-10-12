CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_WH_DAY_ROC
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.07.2022    Oliver Haus         Initial DDL deployment - RWL aggregated values for Cockpits
#  1.1  10.07.2023    Chetana Patil       Added logic for RWL_WEIGHTED_VJ  
#----------------------------------------------------------------------------
*/
(
  client_id
, gl_region_id
, wh_id
, dat_formdate
, currency_iso_cd
, qty_piece_stc_wh
, rwl_nominator
, rwl_weighted
, rwl_weighted_vj
) 
AS
   SELECT
   client_id
 , gl_region_id
 , wh_id
 , dat_formdate
 , currency_iso_cd
 , qty_piece_stc_wh
 , rwl_nominator
 , rwl_weighted
 , rwl_weighted_vj
   FROM p_lew_mart_msi.v_agg_wh_day_roc
;