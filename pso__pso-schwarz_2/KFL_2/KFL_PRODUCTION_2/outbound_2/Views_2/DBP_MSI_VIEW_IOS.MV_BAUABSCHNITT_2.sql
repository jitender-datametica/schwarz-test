-- kkai0912 20160921  - Bezeichnung Testversion herausgenommen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bauabschnitt_2 AS
-- , MIN(cll.bauabschnitt_abgelaufen_fg) AS bauabschnitt_abgelaufen_fg
 -- WHEN v03.cpr_suchfeld_id = 161

-- AND v03.aufgabenart_id IN ('A2', 'Z1')
 -- THEN v02.projekt_id || v03.cpr_aufgabe_id
 -- group by 1,2,3,5
 SELECT
 projekt_nr,
 projekt_id,
 MIN(bauabschnitt_abgelaufen_fg) AS bauabschnitt_abgelaufen_fg,
 bauabschnitt_id_
FROM (SELECT DISTINCT V01.cpr_ext_id AS projekt_nr,
   V01.projekt_id,
   V02.projekt_phase_id -- , v03.cpr_aufgabe_id
 -- , v03.aufgabenart_id
 -- , v02.teil_massn_kz
,
   COALESCE(cll.bauabschnitt_abgelaufen_fg, 0) AS bauabschnitt_abgelaufen_fg,
    CASE
    WHEN V03.cpr_suchfeld_id = 161 AND V02.teil_massn_kz > 1
    THEN V02.projekt_id || V02.projekt_phase_id
    ELSE V02.projekt_id || '0000'
    END AS bauabschnitt_id_
  FROM kfl_production_dbp_view.v_cpr_projekt_per_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_2 AS V02 ON V01.projekt_id = V02.projekt_id AND V02.dat_bis =
      DATE '9999-12-31' AND V01.cpr_systemstatus1_id = 2
   INNER JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_2 AS V03 ON V02.projekt_phase_id = V03.projekt_phase_id AND V03.dat_bis
      = DATE '9999-12-31'
   INNER JOIN kfl_production_dbp_msi_view_ios.mv_projekt_fg_2 AS UFG ON V01.projekt_id = UFG.projekt_id AND UFG.ist_aufnahme_technik_fg
      < 1
   LEFT JOIN (SELECT PH.projekt_id,
     PH.projekt_phase_id,
      CASE
      WHEN CL.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND DATE_ADD(CL.dat_termin, INTERVAL 30 DAY) <= CURRENT_DATE OR PH.cpr_systemstatus2_id
         = 1
      THEN 1
      ELSE 0
      END AS bauabschnitt_abgelaufen_fg
    FROM kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_2 AS CL
     INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_2 AS PH ON CL.projekt_phase_id = PH.projekt_phase_id
     INNER JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_2 AS AU ON PH.projekt_phase_id = AU.projekt_phase_id AND PH.dat_bis
         = DATE '9999-12-31' AND CL.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'
    GROUP BY PH.projekt_id,
     PH.projekt_phase_id,
     bauabschnitt_abgelaufen_fg) AS cll ON V02.projekt_phase_id = cll.projekt_phase_id
  WHERE V01.dat_bis = DATE '9999-12-31') AS ALLES
GROUP BY projekt_nr,
 projekt_id,
 bauabschnitt_id_;