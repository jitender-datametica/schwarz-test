CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_art_kunde_vkorg_vw_zu (in_art_id, mandant_id,
in_art_id_kunde, mandant_id_kunde) AS SELECT in_art_id,
 mandant_id,
 in_art_id AS in_art_id_kunde,
 mandant_id AS mandant_id_kunde
FROM kfl_production_dbp_msi_view_flw.mv_l_in_art AS V01
UNION ALL
SELECT V01.in_art_id,
 V01.mandant_id,
 v02.in_art_id_kunde,
 v02.mandant_id_kunde
FROM kfl_production_dbp_msi_view_flw.mv_l_in_art AS V01
 INNER JOIN (SELECT flw_art_id AS in_art_id,
   mandant_id,
   MAX(flw_art_id_kunde) AS in_art_id_kunde,
   MAX(mandant_id_kunde) AS mandant_id_kunde
  FROM kfl_production_dbp_view.v_flw_art_kunde_vkorg_vw_zu AS V01
  GROUP BY in_art_id,
   mandant_id) AS v02 ON V01.in_art_id = v02.in_art_id AND V01.mandant_id = v02.mandant_id;