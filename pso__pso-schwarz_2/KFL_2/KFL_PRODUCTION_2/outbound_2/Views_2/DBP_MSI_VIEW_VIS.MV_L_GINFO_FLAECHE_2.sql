CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_ginfo_flaeche_2 AS SELECT s01.mandant_id,
 s01.flaeche_quelle_id,
 s01.ginfo_flaeche_typ_id,
 s01.ginfo_flaeche_id,
 ROUND(CAST(CASE
    WHEN SUBSTR(s01.ginfo_flaeche_typ_id, 1, 5) = 'VKF-A'
    THEN SUBSTR(s01.ginfo_flaeche_typ_id, 7, 1)
    WHEN s01.ginfo_flaeche_typ_id = 'VKF' AND s01.ginfo_flaeche_id IN ('02.01', '02.10', '02.08')
    THEN '0'
    ELSE SUBSTR(CAST(- 9 AS STRING), 1, 50)
    END AS BIGNUMERIC), 0) AS abt_id
FROM (SELECT DISTINCT mandant_id,
   flaeche_quelle_id,
   ginfo_flaeche_typ_id,
   ginfo_flaeche_id
  FROM kfl_production_dbp_view.v_l_ginfo_flaeche_2) AS s01
 INNER JOIN (SELECT DISTINCT mandant_id,
   ginfo_flaeche_typ_id,
   ginfo_flaeche_id
  FROM kfl_production_dbp_view.v_ginfo_flaeche_per_2
  WHERE dat_bis = DATE '9999-12-31') AS s02 ON s01.mandant_id = s02.mandant_id AND s01.ginfo_flaeche_id = s02.ginfo_flaeche_id
     AND s01.ginfo_flaeche_typ_id = s02.ginfo_flaeche_typ_id;