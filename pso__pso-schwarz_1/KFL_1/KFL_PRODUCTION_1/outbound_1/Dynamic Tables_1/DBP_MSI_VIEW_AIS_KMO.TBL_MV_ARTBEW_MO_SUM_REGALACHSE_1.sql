CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_mo_sum_regalachse_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.kjmo AS kjmo,
  v01.art_id AS art_id,
  v02.fbb_nr AS fbb_nr,
  v02.fachboden_nr AS fachboden_nr,
  v02.fachboden_pos AS fachboden_pos,
  v01.bewart_id AS bewart_id,
  v01.mandant_id AS mandant_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.gp_id AS gp_id,
  v01.herst_id AS herst_id,
  v01.diff_ek_mep_konz AS diff_ek_mep_konz,
  v01.ek_mep AS ek_mep,
  v01.diff_umsatz_mwst_betrag_konz AS diff_umsatz_mwst_betrag_konz,
  v01.umsatz_mwst_betrag AS umsatz_mwst_betrag,
  v02.kapazitaet_faktor AS kapazitaet_faktor,
  v01.diff_umsatz_netto_konz AS diff_umsatz_netto_konz,
  v01.umsatz_netto AS umsatz_netto,
  v01.menge AS menge,
  v01.diff_einstandspreis_konz AS diff_einstandspreis_konz,
  v01.einstandspreis AS einstandspreis,
  v01.umrechnungskurs_hist AS umrechnungskurs_hist
FROM kfl_production_dbp_data.artbew_mo_sum_1 AS v01
INNER JOIN kfl_production_dbp_data.regalachse_akt_1 AS v02
  ON v01.art_id = v02.art_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.wup_id = v02.wup_id
  AND v01.nb_id = v02.nb_id
WHERE
  v01.mandant_id <> 1
  AND (
    v01.mandant_id <> 5 OR v01.art_id <> 206731500
  )
  AND (
    v01.mandant_id <> 2 OR v01.art_id <> 208124500
  )
  AND (
    v01.mandant_id <> 3 OR v01.art_id <> 208113690
  )
  AND (
    v01.mandant_id <> 6 OR v01.art_id <> 208131570
  )
  AND (
    NOT v01.mandant_id IN (4, 7) OR v01.art_id <> 208114740
  )
  AND (
    v01.mandant_id <> 8 OR v01.art_id <> 208131640
  );
