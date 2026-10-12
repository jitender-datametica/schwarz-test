CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_kunde_2 (kunde_id, aktuell_wup_id, is_akt_wup_id_fg,
mandant_id_kunde, nb_id, kunde_bez, dat_von, dat_bis, buchungskreis_id, verkaufsorganisation_id, wup_typ_id,
nacht_anlieferung_flg, breitengrad, laengengrad) AS SELECT V01.wup_id AS kunde_id,
 V01.aktuell_wup_id,
  CASE
  WHEN V01.aktuell_wup_id = V01.wup_id
  THEN 1
  ELSE 0
  END AS is_akt_wup_id_fg,
 V01.mandant_id AS mandant_id_kunde,
 V01.nb_id,
  CASE
  WHEN V01.nb_id = - 1
  THEN '---'
  ELSE V01.wup_standort
  END AS kunde_bez,
 V01.dat_von,
 V01.dat_bis,
 V01.buchungskreis_id,
 V01.verkaufsorganisation_id,
 V01.wup_typ_id,
 COALESCE(v02.nacht_anlieferung_flg, 0) AS nacht_anlieferung_flg,
 V01.breitengrad,
 V01.laengengrad
FROM kfl_production_dbp_view.v_wup_2 AS V01
 LEFT JOIN (SELECT T1.mandant_id,
   T2.wup_id,
   1 AS nacht_anlieferung_flg
  FROM kfl_production_dbp_view.v_ginfo_flaeche_per_2 AS T1_2
   INNER JOIN kfl_production_dbp_view.v_techn_platz_per_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.techn_platz_id =
     T2.techn_platz_id
  WHERE T1.ginfo_flaeche_typ_id = 'SNF'
   AND T1.ginfo_flaeche_id = '04.04'
   AND T1.ginfo_flaeche_brutto > 0
   AND T1.dat_bis = DATE '9999-12-31'
   AND T2.dat_bis = DATE '9999-12-31') AS v02 ON V01.mandant_id = v02.mandant_id AND V01.wup_id = v02.wup_id
WHERE V01.nb_id IN (2, 0, - 111) AND V01.wup_id > 0
 OR V01.nb_id = - 1 AND V01.wup_id = 0
UNION DISTINCT
SELECT - 3 AS wup_id,
 - 3 AS aktuell_wup_id,
 1,
 mandant_id,
 - 1 AS nb_id,
 'nicht numerisch oder leer' AS kunde_bez,
 DATE('2000-01-01') AS dat_von,
 DATE('9999-12-31') AS dat_bis,
 CAST(NULL AS BIGNUMERIC) AS buchungskreis_id,
 CAST(NULL AS STRING) AS verkaufsorganisation_id,
 0 AS wup_typ_id,
 0 AS nacht_anlieferung_flg,
 CAST(NULL AS BIGNUMERIC) AS breitengrad,
 CAST(NULL AS BIGNUMERIC) AS laengengrad
FROM kfl_production_dbp_view.v_mandant_2;