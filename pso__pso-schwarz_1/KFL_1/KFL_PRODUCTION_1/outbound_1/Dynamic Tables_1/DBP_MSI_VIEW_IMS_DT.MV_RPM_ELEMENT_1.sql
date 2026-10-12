CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_rpm_element_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  COALESCE(v01.rpm_hierarchie_id, '-1') AS rpm_hierarchie_id,
  v01.dat_von AS dat_von,
  inpr.projekt_ext_id AS projekt_ext_id,
  inpr.in_projekt_id AS in_projekt_id,
  inpr.mandant_id AS mandant_id,
  v01.dat_bis AS dat_bis,
  v01.rpm_status_id AS rpm_status_id,
  v01.dat_start_prognose AS dat_start_prognose,
  v01.dat_start_plan AS dat_start_plan,
  v01.dat_start AS dat_start,
  v01.dat_ende_prognose AS dat_ende_prognose,
  v01.dat_ende_plan AS dat_ende_plan,
  v01.dat_ende AS dat_ende,
  v01.land_id AS land_id,
  COALESCE(v01.rpm_phase_id, '1') AS rpm_phase_id,
  COALESCE(v01.rpm_projekt_typ_id, 'ZPPM_SONSTIGES') AS rpm_projekt_typ_id
FROM kfl_production_dbp_view.v_in_projekt_1 AS inpr
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_rpm_element_per_1 AS t
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE) AND rpm_status_id <> -1
) AS v01
  ON inpr.projekt_ext_id = v01.projekt_id;
