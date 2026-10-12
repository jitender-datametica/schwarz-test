CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_flaeche_dn_aktivitaet AS SELECT sub01.mandant_id,
 sub01.flaeche_id,
                 COALESCE(akt.aktivitaet1, '') || COALESCE(akt.aktivitaet2, '') || COALESCE(akt.aktivitaet3, '') ||
               COALESCE(akt.aktivitaet4, '') || COALESCE(akt.aktivitaet5, '') || COALESCE(akt.aktivitaet6, '') ||
            COALESCE(akt.aktivitaet7, '') || COALESCE(akt.aktivitaet8, '') || COALESCE(akt.aktivitaet9, '') || COALESCE(akt
          .aktivitaet10, '') || COALESCE(akt.aktivitaet11, '') || COALESCE(akt.aktivitaet12, '') || COALESCE(akt.aktivitaet13
       , '') || COALESCE(akt.aktivitaet14, '') || COALESCE(akt.aktivitaet15, '') || COALESCE(akt.aktivitaet16, '') ||
  COALESCE(akt.aktivitaet17, '') AS aktivitaeten_gesamt,
  sub01.ergebniss || ' ' AS ergebniss_gesamt
FROM (SELECT mandant_id,
   flaeche_id,
   MAX(COALESCE(TRIM(aktivitaet_ergebnis), '')) AS ergebniss
  FROM kfl_production_dbp_view.v_ivs_flaeche_aktivitaet AS V01
  GROUP BY mandant_id,
   flaeche_id) AS sub01
 LEFT JOIN (SELECT mandant_id,
   flaeche_id,
   MAX(CASE
     WHEN aktivitaet_typ_id = 1
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet1,
   MAX(CASE
     WHEN aktivitaet_typ_id = 2
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet2,
   MAX(CASE
     WHEN aktivitaet_typ_id = 3
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet3,
   MAX(CASE
     WHEN aktivitaet_typ_id = 4
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet4,
   MAX(CASE
     WHEN aktivitaet_typ_id = 5
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet5,
   MAX(CASE
     WHEN aktivitaet_typ_id = 6
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet6,
   MAX(CASE
     WHEN aktivitaet_typ_id = 7
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet7,
   MAX(CASE
     WHEN aktivitaet_typ_id = 8
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet8,
   MAX(CASE
     WHEN aktivitaet_typ_id = 9
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet9,
   MAX(CASE
     WHEN aktivitaet_typ_id = 10
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet10,
   MAX(CASE
     WHEN aktivitaet_typ_id = 11
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet11,
   MAX(CASE
     WHEN aktivitaet_typ_id = 12
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet12,
   MAX(CASE
     WHEN aktivitaet_typ_id = 13
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet13,
   MAX(CASE
     WHEN aktivitaet_typ_id = 14
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet14,
   MAX(CASE
     WHEN aktivitaet_typ_id = 15
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet15,
   MAX(CASE
     WHEN aktivitaet_typ_id = 16
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet16,
   MAX(CASE
     WHEN aktivitaet_typ_id = 17
     THEN '(' || TRIM(SUBSTR(CAST(aktivitaet_typ_id AS STRING), 1, 39)) || ')' || ' ' || CAST(dat_aktivitaet AS STRING)
      || '    '
     ELSE NULL
     END) AS aktivitaet17
  FROM kfl_production_dbp_view.v_ivs_flaeche_aktivitaet AS MFL
  WHERE dat_aktivitaet >= DATE_SUB(CURRENT_DATE, INTERVAL 45 DAY)
  GROUP BY mandant_id,
   flaeche_id) AS akt ON sub01.mandant_id = akt.mandant_id AND sub01.flaeche_id = akt.flaeche_id;