-- MCan1401: Redesign und Optimierung der View inkl .Einbau Bauabschnittslogik!

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_phase_2 (projekt_phase_id, projekt_id, projekt_nr, phase_nr
, phasenart_id, cpr_phase_gruppe_id, dat_freigabe, cpr_suchfeld, teil_massn_fg, bauabschnitt_id, bauabschnitt_bez,
bauabschnitt_langtext, bauabschnitt_abgelaufen_fg, bauabschnitt_nr, einzel_massnahme, teil_massnahme_id,
cpr_systemstatus1_id, cpr_systemstatus2_id, cpr_systemstatus3_id, mandant_id, cpr_phase_version_id,
cpr_phase_version_dat, aufgabenart_id) AS /* LEFT */ SELECT ph.projekt_phase_id,
 ph.projekt_id,
 pr.cpr_ext_id AS projekt_nr,
 ph.cpr_ext_id AS phase_nr,
 ph.phasenart_id,
 CAST(NULL AS STRING) AS cpr_phase_gruppe_id,
 ph.dat_freigabe,
 c.cpr_suchfeld,
 ph.teil_massn_kz AS teil_massn_fg,
 bas.bauabschnitt_id,
 bas.bauabschnitt_bez,
 bas.bauabschnitt_langtext,
 bas.bauabschnitt_abgelaufen_fg -- ALIAS für lfd_nr
,
 SUBSTR(bas.bauabschnitt_id, 33, 4) AS bauabschnitt_nr,
 COALESCE(ph.einzel_massnahme, ' ') AS einzel_massnahme,
 ph.teil_massnahme_id,
 ph.cpr_systemstatus1_id,
 ph.cpr_systemstatus2_id,
 ph.cpr_systemstatus3_id,
 pr.mandant_id -- 20120215: k.kaiser 2 Felder version_phase,  dat_von_phase
,
 ph.cpr_phase_version_id,
 ph.cpr_phase_version_dat,
 '  ' AS aufgabenart_id
FROM kfl_production_dbp_view.v_cpr_phase_per_2 AS ph
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_2 AS pr ON ph.projekt_id = pr.projekt_id AND pr.dat_bis =
    DATE '9999-12-31' AND ph.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_2 AS c ON ph.cpr_suchfeld_id = c.cpr_suchfeld_id
 LEFT JOIN (SELECT projekt_nr,
   projekt_phase_id,
   bauabschnitt_id,
   bauabschnitt_nr,
   bauabschnitt_bez,
   bauabschnitt_langtext,
   bauabschnitt_abgelaufen_fg
  FROM kfl_production_dbp_msi_view_ios.mv_projekt_bauabschnitt_2 AS bas
  GROUP BY projekt_nr,
   projekt_phase_id,
   bauabschnitt_id,
   bauabschnitt_nr,
   bauabschnitt_abgelaufen_fg,
   bauabschnitt_bez,
   bauabschnitt_langtext) AS bas ON pr.cpr_ext_id = bas.projekt_nr AND ph.projekt_phase_id = bas.projekt_phase_id
 LEFT JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_2 AS au ON ph.projekt_phase_id = au.projekt_phase_id AND au.dat_bis =
   DATE '9999-12-31';