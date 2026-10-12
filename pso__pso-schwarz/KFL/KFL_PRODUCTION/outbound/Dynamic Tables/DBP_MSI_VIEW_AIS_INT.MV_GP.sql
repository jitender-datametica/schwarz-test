CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_gp
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.gp_id,
  v01.mandant_id,
  v01.dat_von,
  v01.agb_id,
  v01.dat_bis,
  v01.iso_id,
  v01.eigenverpackung_id,
  v01.eigenmarke_id,
  v01.audit_id,
  v01.audit_dat,
  v01.anlieferung_id,
  v01.gp_name,
  v01.gp_strasse,
  v01.gp_plz,
  v01.gp_ort,
  v01.land_id,
  v01.region_id,
  v02.sap_region_id,
  v01.hgp_id,
  v01.zek_id,
  v01.lieferzeit,
  v01.zahlungsziel_id,
  1 AS ampel_flg,
  v01.gln_bbnr,
  v01.gln_bsnr,
  v01.gln_bubkz,
  NULL AS iln_id,
  v01.ivn,
  v01.markant_id
FROM kfl_production_dbp_view.v_gp AS v01
INNER JOIN kfl_production_dbp_view.v_region AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.land_id = v02.land_id
  AND v01.region_id = v02.region_id
WHERE
  NOT v01.gp_id BETWEEN 10000 AND 999999;