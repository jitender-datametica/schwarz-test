CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ek_kun.tbl_mv_crm_f_ods_bon_kopf_kunde_tag_sum
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  k.mandant_id,
  k.wup_id,
  k.nb_id,
  k.wrg_id,
  k.kundenkarte_id,
  kar.crm_kundenkarte_art_id,
  kon.crm_konto_id,
  kon.crm_konto_typ_id,
  k.dat,
  k.umsatz_netto_sa,
  k.umsatz_netto_af,
  k.umsatz_brutto_sa,
  k.umsatz_brutto_af,
  k.anz_bons
FROM kfl_production_dbp_view.v_crm_kartebew AS k
INNER JOIN (
  SELECT
    kundenkarte_id,
    mandant_id,
    crm_kundenkarte_art_id,
    crm_kundenkarte_nr,
    crm_konto_id,
    gesperrt_fg,
    zeit_von,
    zeit_bis,
    geloescht_fg
  FROM kfl_production_dbp_view.v_crm_l_kundenkarte
  GROUP BY
    kundenkarte_id,
    mandant_id,
    crm_kundenkarte_art_id,
    crm_kundenkarte_nr,
    crm_konto_id,
    gesperrt_fg,
    zeit_von,
    zeit_bis,
    geloescht_fg
) AS kar
  ON k.kundenkarte_id = kar.kundenkarte_id AND k.mandant_id = kar.mandant_id
LEFT JOIN kfl_production_dbp_view.v_crm_l_konto AS kon
  ON kar.crm_konto_id = kon.crm_konto_id;
