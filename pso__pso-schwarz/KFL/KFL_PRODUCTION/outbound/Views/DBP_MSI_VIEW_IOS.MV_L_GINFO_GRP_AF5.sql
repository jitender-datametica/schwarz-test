CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_ginfo_grp_af5 AS SELECT V01.grp_1_id,
 V01.grp_2_id,
 V01.grp_3_id,
 V01.grp_4_id,
 TRIM(V01.kaufland_typ_id) AS kaufland_typ_id,
 V01.flaeche_attribut_id,
 V01.quelle_beauftragung,
 COALESCE(V02.kaufland_typ_bez, '') AS kaufland_typ_bez,
 COALESCE(V03.flaeche_attribut_bez, '') AS flaeche_attribut_bez
FROM kfl_production_dbp_msi_v_view.v_ginfo_grp_aussen_flaechen AS V01
 LEFT JOIN kfl_production_dbp_view.v_l_ginfo_kaufland_typ AS V02 ON V01.kaufland_typ_id = V02.kaufland_typ_id
 LEFT JOIN kfl_production_dbp_view.v_l_ginfo_areaattribut AS V03 ON V01.flaeche_attribut_id = V03.flaeche_attribut_id;