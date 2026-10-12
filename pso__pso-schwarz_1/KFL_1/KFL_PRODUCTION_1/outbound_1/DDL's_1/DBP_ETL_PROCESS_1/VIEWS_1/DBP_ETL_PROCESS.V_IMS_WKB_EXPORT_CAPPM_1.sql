CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.v_ims_wkb_export_cappm_1 (code_, year_, month_, transclass_,
actuals_, obligo_) AS SELECT y.code_,
 y.year_,
 y.month_,
 y.transclass_,
 SUM(COALESCE(z.actuals_, 0)) AS actuals_,
 SUM(COALESCE(z.obligo_, 0)) AS obligo_
FROM (SELECT p.code_,
   Q.kj AS year_,
   SUBSTR(CAST(Q.kjmo AS STRING), 5, 2) AS month_,
    CASE
    WHEN R.berichts_position_it_id = 1
    THEN 'INVSWIT'
    WHEN R.berichts_position_it_id = 2
    THEN 'INVSWNIT'
    WHEN R.berichts_position_it_id = 3
    THEN 'INVHWIT'
    WHEN R.berichts_position_it_id = 4
    THEN 'INVHWNIT'
    WHEN R.berichts_position_it_id = 5
    THEN 'SOINVIT'
    WHEN R.berichts_position_it_id = 6
    THEN 'SOINVNIT'
    WHEN R.berichts_position_it_id = 8
    THEN 'EPKITEXP'
    WHEN R.berichts_position_it_id = 7
    THEN 'EPKITWB'
    WHEN R.berichts_position_it_id = 9
    THEN 'IPKITSIT'
    WHEN R.berichts_position_it_id = 10
    THEN 'EPNITK'
    WHEN R.berichts_position_it_id = 11
    THEN 'EPNITNK'
    WHEN R.berichts_position_it_id = 12
    THEN 'SOKONKIS'
    WHEN R.berichts_position_it_id = 13
    THEN 'SOKOKIS'
    WHEN R.berichts_position_it_id = 14
    THEN 'IPKITKIS'
    WHEN R.berichts_position_it_id = 15
    THEN 'IPKNIDKI'
    WHEN R.berichts_position_it_id = 16
    THEN 'IPKNIKMO'
    WHEN R.berichts_position_it_id = 17
    THEN 'LBAEXKIS'
    WHEN R.berichts_position_it_id = 18
    THEN 'LBASIT'
    WHEN R.berichts_position_it_id = 19
    THEN 'LBAEXFB'
    ELSE 'nicht bekannt'
    END AS transclass_
  FROM (SELECT code_,
     MIN(kjmo) AS kjmo,
     MIN(akt_mo) AS akt_mo
    FROM (SELECT C.in_projekt_id_char AS code_,
        MIN(D.kjmo) AS kjmo,
         MIN(D.akt_mo) - 2 AS akt_mo
       FROM kfl_production_dbp_data.ist_kosten_det_1 AS A
        INNER JOIN kfl_production_dbp_data.tag_1 AS D ON A.dat_buch = D.dat
        INNER JOIN kfl_production_dbp_data.in_psp_element_1 AS B ON A.mandant_id = B.mandant_id AND A.psp_id = B.psp_id
        INNER JOIN kfl_production_dbp_data.in_projekt_1 AS C ON A.mandant_id = C.mandant_id AND B.in_projekt_id = C.in_projekt_id
          
       WHERE C.in_projekt_id_char IN (SELECT it_projekt_id
          FROM kfl_production_dbp_data.it_projekt_plan_1)
       GROUP BY code_
       UNION DISTINCT
       SELECT C.in_projekt_id_char AS code_,
        MIN(D.kjmo) AS kjmo,
         MIN(D.akt_mo) - 2 AS akt_mo
       FROM kfl_production_dbp_data.obligo_per_1 AS A
        INNER JOIN kfl_production_dbp_data.tag_1 AS D ON A.dat_buch = D.dat
        INNER JOIN kfl_production_dbp_data.in_psp_element_1 AS B ON A.mandant_id = B.mandant_id AND A.psp_id = B.psp_id
        INNER JOIN kfl_production_dbp_data.in_projekt_1 AS C ON A.mandant_id = C.mandant_id AND B.in_projekt_id = C.in_projekt_id
          
       WHERE C.in_projekt_id_char IN (SELECT it_projekt_id
          FROM kfl_production_dbp_data.it_projekt_plan_1)
       GROUP BY code_) AS y
    GROUP BY code_) AS p
   INNER JOIN kfl_production_dbp_data.monat_1 AS Q ON p.akt_mo <= Q.akt_mo
   INNER JOIN kfl_production_dbp_data.l_berichts_pos_it_1 AS R ON TRUE
  WHERE Q.akt_mo <= 2
   AND R.berichts_position_it_id NOT IN (14, 15, 16, 19)) AS y
 LEFT JOIN (SELECT C.in_projekt_id_char AS code_,
    D.kj AS year_,
    SUBSTR(CAST(D.kjmo AS STRING), 5, 2) AS month_,
     CASE
     WHEN A.berichts_position_it_id = 1
     THEN 'INVSWIT'
     WHEN A.berichts_position_it_id = 2
     THEN 'INVSWNIT'
     WHEN A.berichts_position_it_id = 3
     THEN 'INVHWIT'
     WHEN A.berichts_position_it_id = 4
     THEN 'INVHWNIT'
     WHEN A.berichts_position_it_id = 5
     THEN 'SOINVIT'
     WHEN A.berichts_position_it_id = 6
     THEN 'SOINVNIT'
     WHEN A.berichts_position_it_id = 8
     THEN 'EPKITEXP'
     WHEN A.berichts_position_it_id = 7
     THEN 'EPKITWB'
     WHEN A.berichts_position_it_id = 9
     THEN 'IPKITSIT'
     WHEN A.berichts_position_it_id = 10
     THEN 'EPNITK'
     WHEN A.berichts_position_it_id = 11
     THEN 'EPNITNK'
     WHEN A.berichts_position_it_id = 12
     THEN 'SOKONKIS'
     WHEN A.berichts_position_it_id = 13
     THEN 'SOKOKIS'
     WHEN A.berichts_position_it_id = 14
     THEN 'IPKITKIS'
     WHEN A.berichts_position_it_id = 15
     THEN 'IPKNIDKI'
     WHEN A.berichts_position_it_id = 16
     THEN 'IPKNIKMO'
     WHEN A.berichts_position_it_id = 17
     THEN 'LBAEXKIS'
     WHEN A.berichts_position_it_id = 18
     THEN 'LBASIT'
     WHEN A.berichts_position_it_id = 19
     THEN 'LBAEXFB'
     ELSE 'nicht bekannt'
     END AS transclass_,
    SUM(A.betrag * E.umrechnungskurs) AS actuals_,
    CAST(SUM(0) AS NUMERIC) AS obligo_
   FROM kfl_production_dbp_data.ist_kosten_det_1 AS A
    INNER JOIN kfl_production_dbp_data.in_psp_element_1 AS B ON A.mandant_id = B.mandant_id AND A.psp_id = B.psp_id
    INNER JOIN kfl_production_dbp_data.in_projekt_1 AS C ON A.mandant_id = C.mandant_id AND B.in_projekt_id = C.in_projekt_id
      
    INNER JOIN kfl_production_dbp_data.tag_1 AS D ON A.dat_buch = D.dat
    INNER JOIN kfl_production_dbp_data.kurs_1 AS E ON A.wrg_id = E.von_wrg_id AND E.dat_bis = PARSE_DATE('%F',
         '9999-12-31') AND E.nach_wrg_id = 'EUR' AND E.kurstyp_id = 3
   WHERE C.in_projekt_id_char IN (SELECT it_projekt_id
      FROM kfl_production_dbp_data.it_projekt_plan_1)
    AND A.berichts_position_it_id BETWEEN 1 AND 19
    AND (A.krk_id <> 'DE02' OR A.mandant_id <> 1)
    AND C.ims_projekt_typ_id = 'P'
    AND B.statistisch_fg = 1
    AND A.hb2_fg = 1
    AND LTRIM(TRIM(COLLATE(A.kostenart_id, '')), '0') NOT IN ('912000', '979002', 'H912000', 'H979002', '48011',
      '940003')
   GROUP BY code_,
    year_,
    month_,
    transclass_
   UNION ALL
   SELECT C.in_projekt_id_char AS code_,
    D.kj AS year_,
    SUBSTR(CAST(D.kjmo AS STRING), 5, 2) AS month_,
     CASE
     WHEN A.berichts_position_it_id = 1
     THEN 'INVSWIT'
     WHEN A.berichts_position_it_id = 2
     THEN 'INVSWNIT'
     WHEN A.berichts_position_it_id = 3
     THEN 'INVHWIT'
     WHEN A.berichts_position_it_id = 4
     THEN 'INVHWNIT'
     WHEN A.berichts_position_it_id = 5
     THEN 'SOINVIT'
     WHEN A.berichts_position_it_id = 6
     THEN 'SOINVNIT'
     WHEN A.berichts_position_it_id = 8
     THEN 'EPKITEXP'
     WHEN A.berichts_position_it_id = 7
     THEN 'EPKITWB'
     WHEN A.berichts_position_it_id = 9
     THEN 'IPKITSIT'
     WHEN A.berichts_position_it_id = 10
     THEN 'EPNITK'
     WHEN A.berichts_position_it_id = 11
     THEN 'EPNITNK'
     WHEN A.berichts_position_it_id = 12
     THEN 'SOKONKIS'
     WHEN A.berichts_position_it_id = 13
     THEN 'SOKOKIS'
     WHEN A.berichts_position_it_id = 14
     THEN 'IPKITKIS'
     WHEN A.berichts_position_it_id = 15
     THEN 'IPKNIDKI'
     WHEN A.berichts_position_it_id = 16
     THEN 'IPKNIKMO'
     WHEN A.berichts_position_it_id = 17
     THEN 'LBAEXKIS'
     WHEN A.berichts_position_it_id = 18
     THEN 'LBASIT'
     WHEN A.berichts_position_it_id = 19
     THEN 'LBAEXFB'
     ELSE 'nicht bekannt'
     END AS transclass_,
    CAST(SUM(0) AS NUMERIC) AS actuals_,
    SUM(A.betrag * E.umrechnungskurs) AS obligo_
   FROM kfl_production_dbp_data.obligo_per_1 AS A
    INNER JOIN kfl_production_dbp_data.in_psp_element_1 AS B ON A.mandant_id = B.mandant_id AND A.psp_id = B.psp_id
    INNER JOIN kfl_production_dbp_data.in_projekt_1 AS C ON A.mandant_id = C.mandant_id AND B.in_projekt_id = C.in_projekt_id
      
    INNER JOIN kfl_production_dbp_data.tag_1 AS D ON A.dat_buch = D.dat
    INNER JOIN kfl_production_dbp_data.kurs_1 AS E ON A.wrg_id = E.von_wrg_id AND E.dat_bis = PARSE_DATE('%F',
         '9999-12-31') AND E.nach_wrg_id = 'EUR' AND E.kurstyp_id = 3
   WHERE C.in_projekt_id_char IN (SELECT it_projekt_id
           FROM kfl_production_dbp_data.it_projekt_plan_1) AND A.berichts_position_it_id BETWEEN 1 AND 19 AND (A.krk_id <>
           'DE02' OR A.mandant_id <> 1) AND C.ims_projekt_typ_id = 'P' AND B.statistisch_fg = 1 AND A.kostenart_id
      NOT LIKE '%912000%'
    OR A.kostenart_id LIKE '%979002%'
    OR A.kostenart_id LIKE '%H912000%'
    OR A.kostenart_id LIKE '%H979002%'
    OR A.kostenart_id LIKE '%48011%' AND A.dat_bis = PARSE_DATE('%F', '9999-12-31')
   GROUP BY code_,
    year_,
    month_,
    transclass_) AS z ON y.code_ = z.code_ AND y.year_ = z.year_ AND y.month_ = z.month_ AND y.transclass_ = z.transclass_
   
GROUP BY y.code_,
 y.year_,
 y.month_,
 y.transclass_;