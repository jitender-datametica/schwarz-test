CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_tag_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  dat AS dat,
  kjmo AS kjmo,
  kjmo_vj AS kjmo_vj,
  wtag_id AS wtag_id,
  kjwo AS kjwo,
  kjwo_vj AS kjwo_vj,
  gjwo AS gjwo,
  gjwo_vj AS gjwo_vj,
  wo_dat_von AS wo_dat_von,
  wo_dat_bis AS wo_dat_bis,
  gjmo AS gjmo,
  gjmo_vj AS gjmo_vj,
  kjqu AS kjqu,
  gjqu AS gjqu,
  kj AS kj,
  gj AS gj,
  kjtag_id AS kjtag_id,
  gjtag_id AS gjtag_id,
  kjwo_kl AS kjwo_kl,
  kjwo_kl_dat_von AS kjwo_kl_dat_von,
  kjwo_kl_dat_bis AS kjwo_kl_dat_bis,
  gjwo_kl AS gjwo_kl,
  gjwo_kl_dat_von AS gjwo_kl_dat_von,
  gjwo_kl_dat_bis AS gjwo_kl_dat_bis,
  dat_vj AS dat_vj,
  akt_tag AS akt_tag,
  akt_mo AS akt_mo,
  akt_mo_komplett AS akt_mo_komplett,
  akt_wo AS akt_wo,
  akt_wo_komplett AS akt_wo_komplett,
  akt_gjwo_kl AS akt_gjwo_kl,
  akt_gjwo_kl_komplett AS akt_gjwo_kl_komplett,
  akt_kjwo_kl AS akt_kjwo_kl,
  akt_kjwo_kl_komplett AS akt_kjwo_kl_komplett,
  akt_gjqu AS akt_gjqu,
  akt_gjqu_komplett AS akt_gjqu_komplett,
  akt_kjqu AS akt_kjqu,
  akt_kjqu_komplett AS akt_kjqu_komplett,
  akt_gj AS akt_gj,
  akt_gj_komplett AS akt_gj_komplett,
  akt_kj AS akt_kj,
  akt_kj_komplett AS akt_kj_komplett,
  mo_gj AS mo_gj,
  mo_kj AS mo_kj,
  DATE_SUB(dat_vj, INTERVAL '364' DAY) AS dat_vvj,
  (
    akt_mo / 3
  ) AS akt_qu,
  IF(
    dat = LAST_DAY(dat),
    LAST_DAY(DATE_ADD(dat, INTERVAL '-1' MONTH)),
    DATE_ADD(dat, INTERVAL '-1' MONTH)
  ) AS dat_vm,
  CASE
    WHEN kjwo / 100 <> kj
    THEN CASE
      WHEN MOD(CAST(kjwo AS BIGNUMERIC), 100) IN (52, 53)
      THEN kj * 100
      ELSE kj * 100 + 53
    END
    ELSE kjwo
  END AS jahrwoche,
  IF(
    dat = LAST_DAY(dat),
    LAST_DAY(DATE_ADD(dat, INTERVAL '-12' MONTH)),
    DATE_ADD(dat, INTERVAL '-12' MONTH)
  ) AS dat_vj_date,
  dat_vj_kt AS dat_vj_kt
FROM kfl_production_dbp_view.v_tag_1;
