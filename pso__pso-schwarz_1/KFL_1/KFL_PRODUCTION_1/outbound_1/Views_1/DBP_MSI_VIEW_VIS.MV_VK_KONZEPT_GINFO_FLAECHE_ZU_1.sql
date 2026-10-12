CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vk_konzept_ginfo_flaeche_zu_1 AS SELECT v01.mandant_id,
 ROUND(CAST(CASE
    WHEN SUBSTR(v01.ginfo_flaeche_typ_id, 1, 5) = 'VKF-A'
    THEN SUBSTR(v01.ginfo_flaeche_typ_id, 7, 1)
    WHEN v01.ginfo_flaeche_typ_id = 'VKF' AND v01.ginfo_flaeche_id IN ('02.01', '02.10', '02.08')
    THEN '0'
    WHEN v01.ginfo_flaeche_typ_id = 'BBF' AND v01.ginfo_flaeche_id IN ('PPL', 'PPE', 'PPB')
    THEN SUBSTR(CAST(- 9 AS STRING), 1, 50)
    ELSE SUBSTR(CAST(- 3 AS STRING), 1, 50)
    END AS BIGNUMERIC), 0) AS abt_id,
 COALESCE(V02.vk_konzept_id, - 1) AS vk_konzept_id,
 v01.ginfo_flaeche_typ_id,
 v01.ginfo_flaeche_id
FROM (SELECT DISTINCT mandant_id,
   ginfo_flaeche_typ_id,
   ginfo_flaeche_id
  FROM kfl_production_dbp_view.v_ginfo_flaeche_per_1
  WHERE dat_bis = DATE '9999-12-31') AS v01
 LEFT JOIN kfl_production_dbp_msi_v_view.v_vk_konzept_ginfo_flaeche_zu_1 AS V02 ON v01.mandant_id = V02.mandant_id AND v01
   .ginfo_flaeche_id = V02.ginfo_flaeche_id;