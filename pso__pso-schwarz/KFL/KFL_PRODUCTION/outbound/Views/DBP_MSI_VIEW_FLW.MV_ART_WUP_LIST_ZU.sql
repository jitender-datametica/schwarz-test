CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_art_wup_list_zu (mandant_id, wup_id, nb_id, art_id,
bezugsweg_id, kdis, listung_id, listung_markt, in_art_id, in_art_nr, in_kunde_id) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.bezugsweg_id,
 V01.kdis,
 V01.listung_id,
  CASE
  WHEN V01.listung_id = 1
  THEN CASE
   WHEN V01.bezugsweg_id = 1
   THEN CASE
    WHEN V01.kdis = 0
    THEN '1'
    ELSE '5'
    END
   WHEN V01.bezugsweg_id = 4
   THEN CASE
    WHEN V01.kdis = 0
    THEN '4'
    ELSE '8'
    END
   ELSE 'ausgelistet'
   END
  ELSE 'ausgelistet'
  END AS listung_markt,
 V03.in_art_id,
 V03.in_art_nr,
 V04.flw_kunde_id AS in_kunde_id
FROM kfl_production_dbp_view.v_art_wup_zu_per AS V01
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_flw_kunde AS V04 ON V01.wup_id = V04.wup_id AND V01.mandant_id = V04.mandant_id
 INNER JOIN (SELECT DISTINCT flw_kunde_id,
   mandant_id
  FROM kfl_production_dbp_view.v_flw_kunde_vkorg_vw_zu
  WHERE flw_vw_id IN (10, 20, 25)) AS v05 ON V04.mandant_id = v05.mandant_id AND V04.flw_kunde_id = v05.flw_kunde_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V01.mandant_id IN (1, 2)
 AND V01.nb_id <> 99;