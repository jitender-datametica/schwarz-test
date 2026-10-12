CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_PRODH_LVL_5_SPR_ZU
AS 

   SELECT
   v01.mandant_id, v01.spr_id, v01.art_col_auspr  AS prodh_lvl_5, v01.art_col_bez     AS prodh_lvl_5_bez

   FROM dbp_view.v_flw_art_col_spr_zu v01
   WHERE flw_art_col_id =5;