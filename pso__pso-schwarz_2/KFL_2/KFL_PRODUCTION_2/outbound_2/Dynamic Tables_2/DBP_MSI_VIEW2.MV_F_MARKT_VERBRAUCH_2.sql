CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_f_markt_verbrauch_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  art_id AS art_id,
  dat AS dat,
  gp_id AS gp_id,
  menge AS markt_verbrauch_menge,
  ek_netto AS markt_verbrauch_ekn,
  ek_netto_bnk AS markt_verbrauch_ekn_bnk
FROM kfl_production_dbp_view.v_artbew_2
WHERE
  mandant_id = 1;
