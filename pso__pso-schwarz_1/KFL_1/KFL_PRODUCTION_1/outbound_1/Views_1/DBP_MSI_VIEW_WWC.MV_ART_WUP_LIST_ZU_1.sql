CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_wup_list_zu_1 (mandant_id, art_id, wup_id, nb_id,
bezugsweg_id, dat_aenderung, kjmo, gjmo, lfgjamon, kdis_kz, listung_markt, listung_fct) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.bezugsweg_id,
 V04.max_dat AS dat_aenderung,
 V04.kjmo,
 V04.gjmo,
 v05.lfgjamon,
  CASE
  WHEN V01.kdis IS NULL OR V01.kdis = 0
  THEN ' '
  ELSE 'K'
  END AS kdis_kz,
  CASE
  WHEN v02.art_id IS NULL
  THEN 'war nie gelistet'
  ELSE CASE
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
   END
  END AS listung_markt,
  CASE
  WHEN CASE
    WHEN v02.art_id IS NULL
    THEN 'war nie gelistet'
    ELSE CASE
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
     END
    END IN ('ausgelistet', 'war nie gelistet')
  THEN NULL
  ELSE CASE
   WHEN v02.art_id IS NULL
   THEN 'war nie gelistet'
   ELSE CASE
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
    END
   END
  END AS listung_fct
FROM kfl_production_dbp_view.v_art_wup_zu_per_1 AS V01
 LEFT JOIN (SELECT mandant_id,
   art_id,
   wup_id
  FROM kfl_production_dbp_view.v_art_list_wup_zu_per_1
  GROUP BY art_id,
   wup_id,
   mandant_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id AND V01
   .nb_id = V03.nb_id
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V04 ON V04.max_dat BETWEEN V01.dat_von AND V01.dat_bis
 INNER JOIN (SELECT V010.mandant_id,
     V010.sap_buchungs_jahr * 100 + V010.buchungsperiode_id AS lfgjamon,
   V010.kjmo
  FROM kfl_production_dbp_view.v_sap_periode_kalender_zu_1 AS V010
   INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V010.mandant_id = V02.mandant_id
  WHERE V010.buchungsperiode_id <= 12
   AND V010.krk_id <> 'DE02') AS v05 ON V01.mandant_id = v05.mandant_id AND V04.kjmo = v05.kjmo
WHERE V04.akt_mo <= 0
 AND ((V03.dat_eroeffnung < CURRENT_DATE OR V03.dat_eroeffnung < DATE_ADD(CURRENT_DATE, INTERVAL 45 DAY)) AND V03.dat_von
     IS NOT NULL OR V03.nb_id <> 0 OR V03.wup_id = 9203)
 AND V03.nb_id <> 99
 AND NOT V03.wup_id BETWEEN 1 AND 999;