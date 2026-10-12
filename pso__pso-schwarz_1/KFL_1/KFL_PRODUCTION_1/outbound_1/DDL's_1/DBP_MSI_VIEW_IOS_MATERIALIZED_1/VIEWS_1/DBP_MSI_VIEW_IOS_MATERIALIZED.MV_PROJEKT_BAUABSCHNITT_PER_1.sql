CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_projekt_bauabschnitt_per_1 (mandant_id, projekt_nr, techn_platz_id
, projekt_nr_endung, projekt_id, sort_projekt_id, projekt_phase_id, teil_massnahme_id, einzel_massnahme, cpr_aufgabe_id
, cpr_suchfeld_id, aufgabenart_id, teil_massn_fg, cpr_projekt_bez_sort, bauabschnitt_gj, projekt_status1,
projekt_status2, projekt_status3, phase_status1, phase_status2, phase_status3, cpr_phase_version_id,
cpr_phase_version_dat, bauabschnitt_id, bauabschnitt_nr, bauabschnitt_abgelaufen_fg, bauabschnitt_bez,
bauabschnitt_langtext, dat_von, dat_bis) AS
-- WHEN v03.cpr_suchfeld_id = 161 AND v03.aufgabenart_id IN ('A2', 'Z1')  THEN
 -- v02.projekt_id || v03.cpr_aufgabe_id

-- WHEN v03.cpr_suchfeld_id = 161 AND v03.aufgabenart_id IN ('A2', 'Z1') THEN
 -- v06.aufgabe_bez

-- WHEN v03.cpr_suchfeld_id = 161 AND v03.aufgabenart_id IN ('A2', 'Z1') THEN
 -- v06.aufgabe_langtext
 SELECT V01.mandant_id
 ,
 V01.cpr_ext_id AS projekt_nr,
 V01.techn_platz_id,
 SUBSTR(V01.cpr_ext_id, 14, 2) AS projekt_nr_endung,
 V01.projekt_id,
 V01.projekt_id AS sort_projekt_id,
 V02.projekt_phase_id,
 V02.teil_massnahme_id,
 V02.einzel_massnahme,
 V03.cpr_aufgabe_id,
 V03.cpr_suchfeld_id,
 V03.aufgabenart_id,
 V02.teil_massn_kz AS teil_massn_fg,
 V04.cpr_projekt_bez AS cpr_projekt_bez_sort,
 cll.bauabschnitt_gj,
 V01.cpr_systemstatus1_id AS projekt_status1,
 V01.cpr_systemstatus2_id AS projekt_status2,
 V01.cpr_systemstatus3_id AS projekt_status3,
 V02.cpr_systemstatus1_id AS phase_status1,
 V02.cpr_systemstatus2_id AS phase_status2,
 V02.cpr_systemstatus3_id AS phase_status3,
 V02.cpr_phase_version_id,
 V02.cpr_phase_version_dat,
  CASE
  WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
  THEN V02.projekt_id || V02.projekt_phase_id
  ELSE V02.projekt_id || '0000'
  END AS bauabschnitt_id,
 SUBSTR(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN V02.projekt_id || V02.projekt_phase_id
   ELSE V02.projekt_id || '0000'
   END, 33, 4) AS bauabschnitt_nr,
  CASE
  WHEN CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN V02.projekt_id || V02.projekt_phase_id
    ELSE V02.projekt_id || '0000'
    END = V02.projekt_id || '0000'
  THEN COALESCE(KK.bauabschnitt_abgelaufen_fg, 1)
  ELSE COALESCE(KK.bauabschnitt_abgelaufen_fg, cll.bauabschnitt_abgelaufen_fg, 0)
  END AS bauabschnitt_abgelaufen_fg,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN V05.cpr_phase_bez
   ELSE V04.cpr_projekt_bez
   END, ' ') AS bauabschnitt_bez,
 COALESCE(CASE
   WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
   THEN V05.cpr_phase_langtext
   ELSE V04.cpr_projekt_langtext
   END, ' ') AS bauabschnitt_langtext,
 V99.dat AS dat_von,
  CASE
  WHEN V99.dat = CURRENT_DATE
  THEN DATE('9999-12-31')
  ELSE V99.dat
  END AS dat_bis
FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS V02 ON V01.projekt_id = V02.projekt_id
 INNER JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_1 AS V03 ON V02.projekt_phase_id = V03.projekt_phase_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V99 ON V99.dat <= CURRENT_DATE AND V99.dat BETWEEN DATE_SUB(CURRENT_DATE,
       INTERVAL 14 DAY) AND (CURRENT_DATE) AND V99.dat BETWEEN V02.dat_von AND V02.dat_bis AND V99.dat BETWEEN V01.dat_von
    AND V01.dat_bis AND V99.dat BETWEEN V03.dat_von AND V03.dat_bis
 LEFT JOIN (SELECT PH.projekt_id,
   PH.projekt_phase_id,
    CASE
    WHEN CL.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND DATE_ADD(CL.dat_termin, INTERVAL 30 DAY) <= CURRENT_DATE OR PH.cpr_systemstatus2_id
       = 1
    THEN 1
    ELSE 0
    END AS bauabschnitt_abgelaufen_fg,
    CASE
    WHEN CL.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND CL.dat_termin IS NOT NULL
    THEN SUBSTR(SUBSTR(CAST(CL.dat_termin AS STRING), 1, 20), 1, 4)
    WHEN CL.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND CL.dat_termin IS NULL
    THEN '9999'
    ELSE NULL
    END AS bauabschnitt_gj
  FROM dbp_msi_view_ios_materialized.mv_cpr_cl_punkt_1 AS CL
   INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS PH ON CL.projekt_phase_id = PH.projekt_phase_id AND CL.cpr_suchfeld_id
      = 'STILLE_EROEFFNUNG'
   INNER JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_1 AS AU ON PH.projekt_phase_id = AU.projekt_phase_id
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS V990 ON V990.dat <= CURRENT_DATE AND V990.dat BETWEEN DATE_SUB(CURRENT_DATE
       ,INTERVAL 14 DAY) AND (CURRENT_DATE) AND V990.dat BETWEEN AU.dat_von AND AU.dat_bis
  GROUP BY PH.projekt_id,
   PH.projekt_phase_id,
   bauabschnitt_abgelaufen_fg,
   bauabschnitt_gj) AS cll ON V02.projekt_phase_id = cll.projekt_phase_id
  -- LEFT OUTER ==> Es gibt Projekte ohne Tabelleninhalte

 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_1 AS V04 ON V01.projekt_id = V04.projekt_id AND V04.dat_bis =
    DATE '9999-12-31' AND V04.spr_id = 22 -- LEFT OUTER ==> Es gibt Phasen ohne Tabelleninhalte

 LEFT JOIN kfl_production_dbp_view.v_cpr_phase_spr_zu_per_1 AS V05 ON V02.projekt_phase_id = V05.projekt_phase_id AND V05
    .dat_bis = DATE '9999-12-31' AND V05.spr_id = 22 -- hier muss ein LEFT rein (kkai0912 160921)

 LEFT JOIN kfl_production_dbp_view.v_cpr_aufgabe_spr_zu_per_1 AS V06 ON V03.cpr_aufgabe_id = V06.cpr_aufgabe_id AND V06.dat_bis
     = DATE '9999-12-31' AND V06.spr_id = 22
 LEFT JOIN dbp_msi_view_ios_materialized.mv_bauabschnitt_1 AS KK ON V01.cpr_ext_id = KK.projekt_nr AND V01.projekt_id
    -- AND KK.bauabschnitt_id  = bauabschnitt_id
 = KK.projekt_id AND KK.bauabschnitt_id_ = V02.projekt_id || '0000'
    -- WHERE v01.dat_bis = '9999-12-31'
;