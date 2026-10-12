CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.tbl_mv_art_gp_wup_nm_zu_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v01.gp_id AS gp_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v03.dat_von AS dat_von,
  v03.dat_bis AS dat_bis,
  v03.ek_netto_bnk AS ek_netto_bnk,
  v03.ek_mep AS ek_mep,
  v03.einstandspreis AS einstandspreis,
  v03.logistikkostenzuschlag AS logistikkostenzuschlag
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS v01
INNER JOIN (
  SELECT
    mandant_id,
    art_id,
    gp_id,
    wup_id,
    dat_von,
    dat_bis,
    ek_netto_bnk,
    ek_mep,
    einstandspreis,
    logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_1
  WHERE
    wup_id > -1
) AS v03
  ON v01.mandant_id = v03.mandant_id
  AND v01.wup_id = v03.wup_id
  AND v01.gp_id = v03.gp_id
  AND v01.art_id = v03.art_id
  AND DATE_ADD(v03.dat_von, INTERVAL '1' DAY) BETWEEN v01.dat_von AND v01.dat_bis
UNION ALL
SELECT
  v01.mandant_id,
  v01.art_id,
  v01.gp_id,
  v01.wup_id,
  v01.nb_id,
  v04.dat_von,
  v04.dat_bis,
  v04.ek_netto_bnk,
  v04.ek_mep,
  v04.einstandspreis,
  v04.logistikkostenzuschlag
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS v01
INNER JOIN (
  SELECT
    mandant_id,
    art_id,
    gp_id,
    wup_id,
    dat_von,
    dat_bis,
    ek_netto_bnk,
    ek_mep,
    einstandspreis,
    logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_1
  WHERE
    wup_id = -1
) AS v04
  ON v01.mandant_id = v04.mandant_id
  AND v01.gp_id = v04.gp_id
  AND v01.art_id = v04.art_id
  AND DATE_ADD(v04.dat_von, INTERVAL '1' DAY) BETWEEN v01.dat_von AND v01.dat_bis;
