CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_GINFO_GRP_AF5_1 as
   SELECT
   v01.grp_1_id, v01.grp_2_id, v01.grp_3_id, v01.grp_4_id, TRIM(v01.kaufland_typ_id) AS kaufland_typ_id, v01.flaeche_attribut_id, v01.quelle_beauftragung, COALESCE (v02.kaufland_typ_bez, '') AS kaufland_typ_bez, COALESCE (v03.flaeche_attribut_bez, '') AS flaeche_attribut_bez
   FROM dbp_msi_v_view.v_ginfo_grp_aussen_flaechen_1 v01
   LEFT OUTER JOIN dbp_view.v_l_ginfo_kaufland_typ_1 v02
   ON v01.kaufland_typ_id = v02.kaufland_typ_id
   LEFT OUTER JOIN dbp_view.v_l_ginfo_areaattribut_1 v03
   ON v01.flaeche_attribut_id = v03.flaeche_attribut_id
   ;