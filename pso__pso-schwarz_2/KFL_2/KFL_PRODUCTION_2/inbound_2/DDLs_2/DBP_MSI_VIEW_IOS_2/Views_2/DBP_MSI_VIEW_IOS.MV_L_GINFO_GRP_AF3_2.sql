CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_GINFO_GRP_AF3_2 as
   SELECT
   v01.grp_1_id, v01.grp_2_id, v01.grp_3_id, v02.grp_bez
   FROM dbp_msi_v_view.v_ginfo_grp_aussen_flaechen_2 v01
   INNER JOIN dbp_msi_v_view.v_l_ginfo_grp_2 v02
   ON  v01.grp_3_id = v02.grp_id
   AND v02.ebene_id = 3
   GROUP BY 1,2,3,4
   ;