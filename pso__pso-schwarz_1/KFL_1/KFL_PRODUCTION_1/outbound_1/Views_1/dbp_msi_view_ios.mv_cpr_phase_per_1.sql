-- und aufgabenart_id in ('A2','Z1')

-- 20160511 k.kaiser: SPEC0009788, bauabschnitte aus der cpr_aufgabe_per_1 werden auch mitberücksichtigt, wenn cpr_suchfeld_id 161 (= cpr_suchfeld_bez = 'CPR_REALISIERUNG')

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_phase_per_1 AS -- neu für Bauabschnitt in der Phasen-VIEW

-- neu bis hier
 SELECT PH.projekt_phase_id,
 PH.projekt_id,
 PR.cpr_ext_id AS projekt_nr,
 PH.cpr_ext_id AS phase_nr,
 PH.phasenart_id,
 CAST(NULL AS STRING) AS cpr_phase_gruppe_id,
 PH.dat_freigabe,
 C.cpr_suchfeld,
 PH.teil_massn_kz AS teil_massn_fg,
 bas.bauabschnitt_id,
 bas.bauabschnitt_bez,
 bas.bauabschnitt_langtext,
 bas.bauabschnitt_abgelaufen_fg -- ALIAS für lfd_nr
,
 SUBSTR(bas.bauabschnitt_id, 33, 4) AS bauabschnitt_nr,
 PH.einzel_massnahme,
 PH.teil_massnahme_id,
 PH.cpr_systemstatus1_id,
 PH.cpr_systemstatus2_id,
 PH.cpr_systemstatus3_id,
 PR.mandant_id,
 T.dat AS dat_von,
  CASE
  WHEN T.dat = CURRENT_DATE
  THEN DATE('9999-12-31')
  ELSE T.dat
  END AS dat_bis,
 '  ' AS aufgabenart_id
FROM kfl_production_dbp_view.v_cpr_phase_per_1 AS PH
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN PH.dat_von AND PH.dat_bis AND T.dat <= CURRENT_DATE AND
   T.dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR ON PH.projekt_id = PR.projekt_id AND T.dat BETWEEN PR.dat_von
   AND PR.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_1 AS AU ON PH.projekt_phase_id = AU.projekt_phase_id AND T.dat
   BETWEEN AU.dat_von AND AU.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_1 AS C ON PH.cpr_suchfeld_id = C.cpr_suchfeld_id
 LEFT JOIN (SELECT projekt_nr,
   bauabschnitt_id,
   bauabschnitt_nr,
   bauabschnitt_bez,
   bauabschnitt_langtext,
   bauabschnitt_abgelaufen_fg
  FROM kfl_production_dbp_msi_view_ios.mv_projekt_bauabschnitt_1 AS BAS
  GROUP BY projekt_nr,
   bauabschnitt_id,
   bauabschnitt_nr,
   bauabschnitt_abgelaufen_fg,
   bauabschnitt_bez,
   bauabschnitt_langtext) AS bas ON PR.cpr_ext_id = bas.projekt_nr;