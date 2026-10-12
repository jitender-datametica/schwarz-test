CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_preissenkungen (mandant_id, art_id, disponent_id, dat, vk_alt,
vk_neu, vz_wup_id, vz_nb_id, anz_wup, anz_gel_wup) AS SELECT mandant_id,
 art_id,
 disponent_id,
 dat,
 vk_alt,
 vk_neu,
 vz_wup_id,
 vz_nb_id,
 anz_wup,
 anz_gel_wup_0 AS anz_gel_wup
FROM (SELECT t17.mandant_id,
   t17.art_id,
   t17.disponent_id,
   t17.dat,
   t17.vk_alt,
   t17.vk_neu,
   t17.vz_wup_id,
   t17.vz_nb_id,
    CASE
    WHEN t17.vk_neu <> t17.vk_alt
    THEN CAST(t17.a0 AS INTEGER)
    ELSE 0
    END AS anz_wup,
   SUM(t17.anz_gel_wup) OVER (PARTITION BY t17.dat, CAST(t17.mandant_id AS STRING), CAST(t17.art_id AS STRING), t17.disponent_id
      , CAST(t17.vz_wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_gel_wup_0
  FROM (SELECT v01.mandant_id,
     v01.art_id,
     v08.disponent_id,
     V03.dat,
     V04.vk_brutto AS vk_alt,
     V02.vk_brutto AS vk_neu,
     COALESCE(t5.vz_wup_id, t12.vz_wup_id) AS vz_wup_id,
     COALESCE(t5.vz_nb_id, - 111) AS vz_nb_id,
     COUNT(DISTINCT V02.wup_id) AS a0,
     COUNT(v01.wup_id) AS anz_gel_wup
    FROM (SELECT mandant_id,
       art_id,
       dat_bis,
       listung_id,
       nb_id,
       kdis,
       wup_id
      FROM kfl_production_dbp_view.v_art_wup_zu_per
      WHERE mandant_id = 1
       AND dat_bis = DATE '9999-12-31'
       AND listung_id = 1
       AND kdis = 0
       AND nb_id <> 99
      GROUP BY mandant_id,
       wup_id,
       nb_id,
       art_id,
       listung_id,
       dat_bis,
       kdis) AS v01
     LEFT JOIN kfl_production_dbp_view.v_art_wup_vk_per AS V02 ON v01.art_id = V02.art_id AND v01.mandant_id = V02.mandant_id
          AND v01.wup_id = V02.wup_id AND v01.nb_id = V02.nb_id
     INNER JOIN kfl_production_dbp_view.v_tag AS V03 ON V03.dat BETWEEN V02.dat_von AND V02.dat_bis
     INNER JOIN kfl_production_dbp_view.v_art_wup_vk_per AS V04 ON V02.art_id = V04.art_id AND V02.wup_id = V04.wup_id
        AND V02.nb_id = V04.nb_id AND V02.mandant_id = V04.mandant_id AND DATE_SUB(V03.dat, INTERVAL 7 DAY) BETWEEN V04
       .dat_von AND V04.dat_bis
     INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V05 ON V02.mandant_id = V05.mandant_id AND V02.art_id = V05.art_id
          AND V05.arthiertyp_id = 2 AND V05.dat_bis = DATE '9999-12-31'
     LEFT JOIN (SELECT mandant_id,
       wup_id,
       art_id,
       nb_id,
       vz_nb_id,
       vz_wup_id
      FROM kfl_production_dbp_view.v_ek_orderbuch
      WHERE vz_wup_id IN (6902, 6903, 6905, 6906, 6907, 6908, 6909)
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(art_id AS STRING)
            , CAST(nb_id AS STRING), CAST(vz_nb_id AS STRING) ORDER BY vz_wup_id IS NULL, vz_wup_id)) = 1) AS t5 ON V02
         .art_id = t5.art_id AND V02.wup_id = t5.wup_id AND V02.nb_id = t5.nb_id AND V02.mandant_id = t5.mandant_id
     LEFT JOIN (SELECT mandant_id,
       wup_id,
       nb_id,
       wg_hierarchie_id
      FROM kfl_production_dbp_view.v_vz_wg_wup_zu_per
      WHERE arthiertyp_id = 6
       AND wg_hierarchie_ebene_id = 5
       AND mandant_id = 1
       AND vz_wup_id IN (6902, 6903, 6905, 6906, 6907, 6908, 6909)
       AND dat_bis = DATE '9999-12-31'
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(wg_hierarchie_id AS STRING)
            ORDER BY vz_wup_id IS NULL, vz_wup_id)) = 1) AS v07_1 ON V05.mandant_id = v07_1.mandant_id AND V05.wg_id =
         v07_1.wg_hierarchie_id AND V02.wup_id = v07_1.wup_id AND V02.nb_id = v07_1.nb_id
     LEFT JOIN (SELECT mandant_id,
       wup_id,
       nb_id,
       vz_wup_id,
       wg_hierarchie_id
      FROM kfl_production_dbp_view.v_vz_wg_wup_zu_per
      WHERE arthiertyp_id IN (- 1, 6)
       AND wg_hierarchie_ebene_id IN (- 1, 5)
       AND mandant_id = 1
       AND vz_wup_id IN (6902, 6903, 6905, 6906, 6907, 6908, 6909)
       AND dat_bis = DATE '9999-12-31'
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(wg_hierarchie_id AS STRING)
            ORDER BY vz_wup_id IS NULL, vz_wup_id)) = 1) AS t12 ON V02.mandant_id = t12.mandant_id AND V02.wup_id = t12
         .wup_id AND V02.nb_id = t12.nb_id AND COALESCE(v07_1.wg_hierarchie_id, - 1) = t12.wg_hierarchie_id
     LEFT JOIN (SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       disponent_id,
       dat_bis
      FROM kfl_production_dbp_view.v_art_wup_status_per
      WHERE mandant_id = 1
       AND wup_id IN (6902, 6903, 6905, 6906, 6907, 6908, 6909)) AS v08 ON v01.art_id = v08.art_id AND v01.mandant_id =
          v08.mandant_id AND COALESCE(t5.vz_wup_id, t12.vz_wup_id) = v08.wup_id AND COALESCE(t5.vz_nb_id, - 111) = v08.nb_id
         AND v08.dat_bis = DATE '9999-12-31'
    WHERE v01.mandant_id = 1
    GROUP BY v01.mandant_id,
     v01.art_id,
     v08.disponent_id,
     V03.dat,
     vk_alt,
     vk_neu,
     vz_wup_id,
     vz_nb_id) AS t17) AS t2
WHERE vk_alt <> vk_neu;