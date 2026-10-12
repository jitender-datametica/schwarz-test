CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bauabschnitt_2 (projekt_nr, projekt_id,
bauabschnitt_abgelaufen_fg, bauabschnitt_id_) AS -- , MIN(cll.bauabschnitt_abgelaufen_fg) AS bauabschnitt_abgelaufen_fg

-- WHEN v03.cpr_suchfeld_id = 161
 -- AND v03.aufgabenart_id IN ('A2', 'Z1')

-- THEN v02.projekt_id || v03.cpr_aufgabe_id
 -- group by 1,2,3,5
 SELECT projekt_nr,
 projekt_id,
 MIN(bauabschnitt_abgelaufen_fg) AS bauabschnitt_abgelaufen_fg,
 bauabschnitt_id_
FROM (SELECT DISTINCT v01.cpr_ext_id AS projekt_nr,
   v01.projekt_id,
   v02.projekt_phase_id -- , v03.cpr_aufgabe_id
 -- , v03.aufgabenart_id
 -- , v02.teil_massn_kz
,
   COALESCE(cll.bauabschnitt_abgelaufen_fg, 0) AS bauabschnitt_abgelaufen_fg,
    CASE
    WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
    THEN v02.projekt_id || v02.projekt_phase_id
    ELSE v02.projekt_id || '0000'
    END AS bauabschnitt_id_
  FROM kfl_production_dbp_view.v_cpr_projekt_per_2 AS v01
   INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_2 AS v02 ON v01.projekt_id = v02.projekt_id AND v02.dat_bis =
      DATE '9999-12-31' AND v01.cpr_systemstatus1_id = 2
   INNER JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_2 AS v03 ON v02.projekt_phase_id = v03.projekt_phase_id AND v03.dat_bis
      = DATE '9999-12-31'
   INNER JOIN kfl_production_dbp_msi_view_ios.mv_projekt_fg_2 AS ufg ON v01.projekt_id = ufg.projekt_id AND ufg.ist_aufnahme_technik_fg
      < 1
   LEFT JOIN (SELECT ph.projekt_id,
     ph.projekt_phase_id,
      CASE
      WHEN cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND DATE_ADD(cl.dat_termin, INTERVAL 30 DAY) <= CURRENT_DATE OR ph.cpr_systemstatus2_id
         = 1
      THEN 1
      ELSE 0
      END AS bauabschnitt_abgelaufen_fg
    FROM kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_2 AS cl
     INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_2 AS ph ON cl.projekt_phase_id = ph.projekt_phase_id
     INNER JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_2 AS au ON ph.projekt_phase_id = au.projekt_phase_id AND ph.dat_bis
         = DATE '9999-12-31' AND cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'
    GROUP BY ph.projekt_id,
     ph.projekt_phase_id,
     bauabschnitt_abgelaufen_fg) AS cll ON v02.projekt_phase_id = cll.projekt_phase_id
  WHERE v01.dat_bis = DATE '9999-12-31') AS ALLES
GROUP BY projekt_nr,
 projekt_id,
 bauabschnitt_id_;