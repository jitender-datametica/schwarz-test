CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_art_gp_wup_rueckbewertung_mo_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.kjmo AS kjmo,
  v03.kjmo AS kjmo_rbw_mseg,
  v01.art_id AS art_id,
  v02.gp_id AS gp_id,
  v02.wup_id AS wup_id,
  v02.nb_id AS nb_id,
  v01.dat_gueltig_von AS dat_gueltig_von,
  v01.dat_gueltig_bis AS dat_gueltig_bis,
  v01.dat_abzug AS dat_abzug,
  v01.wrg_id AS wrg_id,
  (
    MAX(v01.preis_ek_mep_vor_fwu) - MAX(v01.preis_ek_nettonetto)
  ) * SUM(v03.menge_lagerbew_bme) AS kmo_we_bonus_artgenau,
  (
    MAX(v01.preis_ek_mep) + MAX(v01.preis_ek_netto_bnk)
  ) * SUM(v03.menge_lagerbew_bme) AS de_we_bonus_artgenau,
  (
    MAX(v01.preis_ek_einstandspreis) + MAX(v01.preis_ek_netto_bnk)
  ) * SUM(v03.menge_lagerbew_bme) AS de_we_bonus_klep,
  MAX(v01.preis_kmep_einh_o_fwu) * SUM(v03.menge_lagerbew_bme) AS we_bonus,
  SUM(v03.menge_lagerbew_bme) AS menge,
  SUM(v03.betrag_lagerbew) AS dmbtr
FROM kfl_production_dbp_msi_v_view.v_art_gp_wup_rueckbewertung_mo_1 AS v01
INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.art_id = v02.art_id
  AND v01.dat_gueltig_von BETWEEN v02.dat_von AND v02.dat_bis
  AND (
    v01.wup_id = -1
    AND v01.gp_id = v02.gp_id
    OR v01.gp_id = v02.gp_id
    AND v01.wup_id = v02.wup_id
    AND v01.wup_id <> -1
  )
INNER JOIN kfl_production_dbp_view.v_lagerbew_det_wwc_monat_1 AS v03
  ON v01.mandant_id = v03.mandant_id
  AND v01.art_id = v03.art_id
  AND v02.wup_id = v03.wup_id
INNER JOIN kfl_production_dbp_view.v_monat_1 AS v08
  ON v03.kjmo = v08.kjmo AND v08.akt_gj BETWEEN -1 AND 0
GROUP BY
  v01.mandant_id,
  v01.kjmo,
  kjmo_rbw_mseg,
  v01.art_id,
  v02.gp_id,
  v02.wup_id,
  v02.nb_id,
  v01.dat_gueltig_von,
  v01.dat_gueltig_bis,
  v01.dat_abzug,
  v01.wrg_id;
