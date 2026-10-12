CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_wup_techn_platz_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  wp.mandant_id AS mandant_id,
  wp.nb_id AS nb_id,
  wp.wup_id AS wup_id,
  tpl.techn_platz_id AS techn_platz_id,
  COALESCE(tpl2.baujahr, 9999) AS baujahr,
  COALESCE(tpl2.ginfo_bauform_id, -1) AS ginfo_bauform_id,
  tpl2.anz_kassen AS anz_kassen
FROM (
  SELECT
    mandant_id,
    nb_id,
    wup_id
  FROM kfl_production_dbp_view.v_wup_1
) AS wp
LEFT JOIN (
  SELECT
    mandant_id,
    techn_platz_id,
    wup_id
  FROM kfl_production_dbp_view.v_techn_platz_per_1
  WHERE
    techn_platz_ebene_id = 2 AND dat_bis = CAST('9999-12-31' AS DATE)
) AS tpl
  ON wp.mandant_id = tpl.mandant_id AND wp.wup_id = tpl.wup_id
LEFT JOIN (
  SELECT
    mandant_id,
    techn_platz_id,
    baujahr,
    ginfo_markt_typ,
    ginfo_bauform_id,
    anz_kassen
  FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per_1 AS s01
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
) AS tpl2
  ON tpl.techn_platz_id = tpl2.techn_platz_id;
