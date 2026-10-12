CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.tbl_mv_rpm_fin_planung
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.dat_von AS dat_von,
  v03.rpm_hierarchie_id AS rpm_hierarchie_id,
  v03.fin_kat_hierarchie_id AS fin_kat_hierarchie_id,
  v03.fin_kategorie_id AS fin_kategorie_id,
  COALESCE(v03.fin_kat_version_id, ' ') AS fin_kat_version_id,
  v03.fin_kat_version_dat AS fin_kat_version_dat,
  v02.fin_gruppe_hierarchie_id AS fin_gruppe_hierarchie_id,
  v02.fin_gruppe_id AS fin_gruppe_id,
  v01.rpm_plantyp_id AS rpm_plantyp_id,
  v02.fin_gruppe_version_id AS fin_gruppe_version_id,
  v02.fin_gruppe_version_dat AS fin_gruppe_version_dat,
  v01.dat_start AS dat_start,
  COALESCE(v020.maxkp_fg, 0) AS maxkp_fg,
  v300.umrechnungskurs AS umrechnungskurs,
  v01.betrag AS betrag
FROM kfl_production_dbp_view.v_rpm_fin_kategorie AS v03
LEFT JOIN kfl_production_dbp_view.v_rpm_fin_gruppe AS v02
  ON v03.fin_kategorie_id = v02.fin_kategorie_id
  AND v03.fin_kat_hierarchie_id = v02.fin_kat_hierarchie_id
LEFT JOIN kfl_production_dbp_view.v_rpm_fin_plan AS v01
  ON v02.fin_gruppe_hierarchie_id = v01.fin_gruppe_hierarchie_id
  AND v01.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN (
  SELECT
    t1.rpm_hierarchie_id,
    t1.rpm_plantyp_id,
    1 AS maxkp_fg
  FROM (
    SELECT
      fk.rpm_hierarchie_id,
      MAX(fp.rpm_plantyp_id) AS rpm_plantyp_id,
      SUM(fp.betrag) AS a0
    FROM kfl_production_dbp_view.v_rpm_fin_plan AS fp
    INNER JOIN kfl_production_dbp_view.v_rpm_fin_gruppe AS fg
      ON fp.fin_gruppe_hierarchie_id = fg.fin_gruppe_hierarchie_id
    INNER JOIN kfl_production_dbp_view.v_rpm_fin_kategorie AS fk
      ON fg.fin_kat_hierarchie_id = fk.fin_kat_hierarchie_id
    WHERE
      fp.dat_bis = CAST('9999-12-31' AS DATE)
      AND fp.rpm_plantyp_id IN (1, 2, 3, 4, 11, 21, 22, 23, 24, 25, 26)
    GROUP BY
      fk.rpm_hierarchie_id
    HAVING
      a0 <> 0
  ) AS t1
) AS v020
  ON v03.rpm_hierarchie_id = v020.rpm_hierarchie_id
  AND v01.rpm_plantyp_id = v020.rpm_plantyp_id
INNER JOIN kfl_production_dbp_view.v_kurs AS v300
  ON v01.dat_von BETWEEN v300.dat_von AND v300.dat_bis
  AND v01.wrg_id = v300.von_wrg_id
  AND v300.kurstyp_id = 3
  AND v300.nach_wrg_id = 'EUR';
