-- MCan1401: Redesign und Optimierung der View inkl .Einbau Bauabschnittslogik!

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_phase AS /* LEFT */ SELECT PH.projekt_phase_id,
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
 COALESCE(PH.einzel_massnahme, ' ') AS einzel_massnahme,
 PH.teil_massnahme_id,
 PH.cpr_systemstatus1_id,
 PH.cpr_systemstatus2_id,
 PH.cpr_systemstatus3_id,
 PR.mandant_id -- 20120215: k.kaiser 2 Felder version_phase,  dat_von_phase
,
 PH.cpr_phase_version_id,
 PH.cpr_phase_version_dat,
 '  ' AS aufgabenart_id
FROM kfl_production_dbp_view.v_cpr_phase_per AS PH
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS PR ON PH.projekt_id = PR.projekt_id AND PR.dat_bis =
    DATE '9999-12-31' AND PH.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld AS C ON PH.cpr_suchfeld_id = C.cpr_suchfeld_id
 LEFT JOIN (SELECT projekt_nr,
   projekt_phase_id,
   bauabschnitt_id,
   bauabschnitt_nr,
   bauabschnitt_bez,
   bauabschnitt_langtext,
   bauabschnitt_abgelaufen_fg
  FROM kfl_production_dbp_msi_view_ios.mv_projekt_bauabschnitt AS BAS
  GROUP BY projekt_nr,
   projekt_phase_id,
   bauabschnitt_id,
   bauabschnitt_nr,
   bauabschnitt_abgelaufen_fg,
   bauabschnitt_bez,
   bauabschnitt_langtext) AS bas ON PR.cpr_ext_id = bas.projekt_nr AND PH.projekt_phase_id = bas.projekt_phase_id
 LEFT JOIN kfl_production_dbp_view.v_cpr_aufgabe_per AS AU ON PH.projekt_phase_id = AU.projekt_phase_id AND AU.dat_bis =
   DATE '9999-12-31';