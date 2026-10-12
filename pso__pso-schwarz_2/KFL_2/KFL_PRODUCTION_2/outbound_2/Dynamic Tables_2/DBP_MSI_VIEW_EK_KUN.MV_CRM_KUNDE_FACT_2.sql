CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_kunde_fact_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.crm_kunde_id AS crm_kunde_id,
  v01.vorzugsfiliale_wup_id AS vorzugsfiliale_wup_id,
  v01.nb_id AS nb_id,
  v01.vorzugsfiliale_mandant_id AS vorzugsfiliale_mandant_id,
  DATE(v01.zeit_registrierung) AS dat_registrierung,
  DATE(v01.zeit_abmeldung) AS dat_abmeldung,
  v01.kundenherkunft_cd AS kundenherkunft_id,
  v02.dat AS dat,
  v02.kjmo AS kjmo,
  v03.crm_konto_id AS crm_konto_id,
  v01.kunde_mandant_id AS kunde_mandant_id,
  v04.kjwo_ww AS kjwo_ww
FROM kfl_production_dbp_data.crm_l_kunde_2 AS v01
INNER JOIN kfl_production_dbp_data.tag_2 AS v02
  ON v02.dat BETWEEN DATE(v01.zeit_registrierung) AND (
    DATE(v01.zeit_abmeldung)
  )
INNER JOIN kfl_production_dbp_data.crm_l_konto_2 AS v03
  ON v01.crm_kunde_id = v03.crm_kunde_id
LEFT JOIN kfl_production_dbp_data.werbewoche_kl_2 AS v04
  ON v02.dat = v04.dat AND v01.kunde_mandant_id = v04.mandant_id
WHERE
  v02.akt_tag <= 0 AND v02.akt_kj IN (-2, -1, 0);
