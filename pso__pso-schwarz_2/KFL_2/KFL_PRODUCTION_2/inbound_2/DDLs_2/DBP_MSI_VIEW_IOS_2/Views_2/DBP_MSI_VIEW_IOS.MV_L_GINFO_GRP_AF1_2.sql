CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_GINFO_GRP_AF1_2 as
   SELECT
   grp_id      AS grp_1_id, grp_bez
   FROM dbp_msi_v_view.v_l_ginfo_grp_2
   WHERE ebene_id = 1
;