CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_gp_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.gp_id AS gp_id,
  v01.mandant_id AS mandant_id,
  v01.dat_von AS dat_von,
  v01.agb_id AS agb_id,
  v01.dat_bis AS dat_bis,
  v01.iso_id AS iso_id,
  v01.eigenverpackung_id AS eigenverpackung_id,
  v01.eigenmarke_id AS eigenmarke,
  v01.audit_id AS audit,
  v01.audit_dat AS audit_dat,
  v01.anlieferung_id AS anlieferung,
  v01.gp_name AS gp_name,
  v01.gp_strasse AS strasse,
  v01.gp_plz AS plz,
  v01.gp_ort AS ort,
  v01.land_id AS land_id,
  v01.region_id AS region_id,
  v02.sap_region_id AS sap_region_id,
  v01.hgp_id AS hgp_id,
  v01.zek_id AS zek_id,
  v01.lieferzeit AS lieferzeit,
  v01.zahlungsziel_id AS zahlungsziel,
  1 AS ampel_flg,
  v01.gln_bbnr AS gln_bbnr,
  v01.gln_bsnr AS gln_bsnr,
  v01.gln_bubkz AS gln_bubkz,
  NULL AS iln_id,
  v01.ivn AS ivn,
  v01.markant_id AS markant_id
FROM kfl_production_dbp_view.v_gp_1 AS v01
INNER JOIN kfl_production_dbp_view.v_region_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.land_id = v02.land_id
  AND v01.region_id = v02.region_id
WHERE
  v01.mandant_id = 1 AND NOT v01.gp_id BETWEEN 10000 AND 999999;
