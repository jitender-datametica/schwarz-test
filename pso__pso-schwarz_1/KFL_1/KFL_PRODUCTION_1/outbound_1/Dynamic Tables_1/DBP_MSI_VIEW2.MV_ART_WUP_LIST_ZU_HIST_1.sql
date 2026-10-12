CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_wup_list_zu_hist_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  art_id AS art_id,
  bezugsweg_id AS bezugsweg_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  kdis AS kdis,
  listung_id AS listung_id,
  CASE
    WHEN listung_id = 1
    THEN CASE
      WHEN bezugsweg_id = 1
      THEN CASE WHEN kdis = 0 THEN '1' ELSE '5' END
      WHEN bezugsweg_id = 4
      THEN CASE WHEN kdis = 0 THEN '4' ELSE '8' END
      ELSE 'ausgelistet'
    END
    ELSE 'ausgelistet'
  END AS listung_markt
FROM kfl_production_dbp_view.v_art_wup_zu_per_1
WHERE
  mandant_id = 1 AND nb_id <> 99;
