-- kkaiser 1151119 gesperrte Phasen  nun wirklich ausgesperrt
 -- ,bauabschnitt_id

-- k.kaiser #616127, #616128 es sollen auch gesperrte Phasen ausgefiltert werden

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bauabschnitt_abgelaufen_1 (projekt_nr, projekt_id,
projekt_phase_id, bauabschnitt_abgelaufen_kz) AS SELECT PR.projekt_nr,
 PR.projekt_id,
 PH.projekt_phase_id,
 COALESCE(cll.bauabschnitt_abgelaufen_kz, 0) AS bauabschnitt_abgelaufen_kz
FROM kfl_production_dbp_view.v_cpr_phase_per_1 AS PH
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_cpr_projekt_1 AS PR ON PH.projekt_id = PR.projekt_id
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_projekt_fg_1 AS FG ON PR.projekt_id = FG.projekt_id
 LEFT JOIN (SELECT PH0.projekt_id,
   PH0.projekt_phase_id,
    CASE
    WHEN CL.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND DATE_ADD(CL.dat_termin, INTERVAL 30 DAY) <= CURRENT_DATE OR PH0.cpr_systemstatus2_id
       = 1
    THEN 1
    ELSE 0
    END AS bauabschnitt_abgelaufen_kz
  FROM kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_1 AS CL
   INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS PH0 ON CL.projekt_phase_id = PH0.projekt_phase_id AND PH0.dat_bis
       = DATE '9999-12-31' AND CL.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' -- and ph.cpr_systemstatus2_id <> 1

  GROUP BY PH0.projekt_id,
   PH0.projekt_phase_id,
   bauabschnitt_abgelaufen_kz) AS cll ON PH.projekt_phase_id = cll.projekt_phase_id
WHERE SUBSTR(PR.projekt_nr, 14, 2) IN ('NB_1', 'UB', 'ST', 'RE_1', 'RN', 'RG', 'RX', 'SO', 'RU', 'TK', 'GA', 'IG', 'SL')
 AND PH.dat_bis = DATE '9999-12-31'
 AND PR.cpr_systemstatus1_id = 2
 AND FG.ist_aufnahme_technik_fg < 1
 AND FG.apl_nat_fg = 1
 AND cll.projekt_phase_id IS NOT NULL
GROUP BY PR.projekt_nr,
 PR.projekt_id,
 PH.projekt_phase_id,
 bauabschnitt_abgelaufen_kz;