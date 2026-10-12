CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ginfo_aussenflaechen_2 AS SELECT V01.techn_platz_id,
 V02.grp_1_id,
 V02.grp_2_id,
 V02.grp_3_id,
 V02.grp_4_id,
 TRIM(V02.kaufland_typ_id) AS kaufland_typ_id,
 V02.flaeche_attribut_id,
 V02.quelle_beauftragung,
 V01.ginfo_flaeche_brutto
FROM kfl_production_dbp_view.v_ginfo_flaeche_det_per_2 AS V01
 INNER JOIN kfl_production_dbp_msi_v_view.v_ginfo_grp_aussen_flaechen_2 AS V02 ON V01.kaufland_typ_id = V02.kaufland_typ_id
  
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V02.kaufland_typ_id <> '-1'
UNION ALL
SELECT V01.techn_platz_id,
 V02.grp_1_id,
 V02.grp_2_id,
 V02.grp_3_id,
 V02.grp_4_id,
 TRIM(V02.kaufland_typ_id) AS kaufland_typ_id,
 V02.flaeche_attribut_id,
 V02.quelle_beauftragung,
  CASE
  WHEN V02.quelle_beauftragung = CAST(- 1 AS BIGNUMERIC)
  THEN 0
  WHEN V02.quelle_beauftragung = 1
  THEN V01.flaeche_cad
  WHEN V02.quelle_beauftragung = 2
  THEN V01.flaeche_schaetzung
  WHEN V02.quelle_beauftragung = 3
  THEN V01.flaeche_beauftragung
  ELSE NULL
  END AS ginfo_flaeche_brutto
FROM kfl_production_dbp_view.v_ginfo_flaeche_areaattr_per_2 AS V01
 INNER JOIN kfl_production_dbp_msi_v_view.v_ginfo_grp_aussen_flaechen_2 AS V02 ON V01.flaeche_attribut_id = V02.flaeche_attribut_id
  
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V02.flaeche_attribut_id <> - 1
 AND V02.quelle_beauftragung <> - 1;