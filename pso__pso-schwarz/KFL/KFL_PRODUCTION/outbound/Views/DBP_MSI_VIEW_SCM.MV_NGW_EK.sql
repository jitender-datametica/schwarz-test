
-- vz
 -- nur versp.
 -- 2025-11-17, dknop, update definition of DIFF_ID, SOLL_IST_LIEFERDATUM_DIFF_LATE

-- SUM(CASE WHEN t0.dat_buch <> '9999-12-31' AND t0.dat_buch > t0.DAT_LIEF_BEWERTUNG THEN t0.SOLL_IST_LIEFERDATUM_DIFF else 0 END) AS SOLL_IST_LIEFERDATUM_DIFF_LATE, -- nur versp.

-- 2025-11-14, AP0299365, dknop, initial

-- X = Nichtlieferung, V=Verspätung, notwendig für Metrik-Level damit bei Anzahl Tage gesamt der Schnitt wie bisher gerechnet und bei Verspätung das Buchungsdatum nicht doppelt gezählt wird

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ngw_ek (mandant_id, dat_lief_bewertung, dat_lief_wunsch, gp_id
, wup_id, nb_id, art_id, lagerort_id, endlief_fg_ekpo, loesch_fg_ekpo, selbstabhol_fg, diff_id,
soll_ist_lieferdatum_diff, soll_ist_lieferdatum_diff_late, menge_lief_soll_kolli_vz, menge_lief_ist_kolli_vz,
anz_dat_buch, menge_lief_ist_kolli_markt, menge_lief_soll_kolli_markt) AS SELECT mandant_id,
 dat_lief_bewertung,
 dat_lief_wunsch,
 gp_id,
 wup_id,
 nb_id,
 art_id,
 lagerort_id,
 COALESCE(endlief_fg_ekpo, 1) AS endlief_fg_ekpo,
 COALESCE(loesch_fg_ekpo, 0) AS loesch_fg_ekpo,
 selbstabhol_fg,
  CASE
  WHEN dat_buch IN (DATE '1900-01-01', DATE '9999-12-31') AND endlief_fg_ekpo = 1
  THEN 'X'
  WHEN dat_buch > dat_lief_bewertung
  THEN 'V'
  WHEN dat_buch < dat_lief_bewertung
  THEN 'Z'
  ELSE ''
  END AS diff_id,
 SUM(soll_ist_lieferdatum_diff) AS soll_ist_lieferdatum_diff,
 SUM(CASE
   WHEN dat_buch > dat_lief_bewertung AND dat_buch NOT IN (DATE '1900-01-01', DATE '9999-12-31') OR dat_buch IN (DATE '1900-01-01'
       , DATE '9999-12-31') AND endlief_fg_ekpo = 0
   THEN soll_ist_lieferdatum_diff
   ELSE 0
   END) AS soll_ist_lieferdatum_diff_late,
 SUM(menge_best_kolli_orig) AS menge_lief_soll_kolli_vz,
 SUM(menge_lief_ist_kolli) AS menge_lief_ist_kolli_vz,
 COUNT(DISTINCT STRUCT( mandant_id, best_beleg_id, best_beleg_pos_id, dat_buch)) AS anz_dat_buch,
 0 AS menge_lief_ist_kolli_markt,
 0 AS menge_lief_soll_kolli_markt
FROM kfl_production_dbp_msi_view_scm.mv_dt_lieferantenmanagement AS T0
GROUP BY mandant_id,
 dat_lief_bewertung,
 dat_lief_wunsch,
 gp_id,
 wup_id,
 nb_id,
 art_id,
 lagerort_id,
 COALESCE(endlief_fg_ekpo, 1),
 COALESCE(loesch_fg_ekpo, 0),
 selbstabhol_fg,
 diff_id
UNION DISTINCT
SELECT mandant_id,
 CAST(NULL AS DATE) AS dat_lief_bewertung,
 dat_lief_soll AS dat_lief_wunsch,
 gp_id,
 wup_id,
 nb_id,
 art_id,
 lagerort_id,
 1 AS endlief_fg_ekpo,
 0 AS loesch_fg_ekpo,
 0 AS selbstabhol_fg,
 diff_id,
 0 AS soll_ist_lieferdatum_diff,
 0 AS soll_ist_lieferdatum_diff_late,
 0 AS menge_lief_soll_kolli_vz,
 0 AS menge_lief_ist_kolli_vz,
 0 AS anz_dat_buch,
 menge_lief_ist_kolli_markt,
 menge_lief_soll_kolli_markt
FROM kfl_production_dbp_msi_view_scm.mv_dt_fehlmengen_ngw_ek;

