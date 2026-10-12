CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_vs
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.vs_id AS vs_id,
  v03.ma_anrede AS ma_anrede,
  CASE WHEN v01.vs_id = 0 AND v01.mandant_id = 1 THEN '' ELSE v03.ma_name END AS ma_name,
  v03.ma_vorname AS ma_vorname
FROM kfl_production_dbp_view.v_vs AS v01
INNER JOIN (
  SELECT DISTINCT
    w.mandant_id,
    w.vs_id,
    MAX(wd.gl_vertrieb_id) OVER (
      PARTITION BY CAST(w.mandant_id AS STRING), CAST(w.vs_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS gl_vertrieb_id
  FROM kfl_production_dbp_view.v_wup AS w
  LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm AS wd
    ON w.mandant_id = wd.mandant_id AND w.wup_id = wd.wup_id
  WHERE
    w.nb_id IN (-2, -1, 0)
    AND w.dat_eroeffnung < CAST('9999-12-31' AS DATE)
    AND w.dat_bis = CAST('9999-12-31' AS DATE)
) AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.vs_id = v02.vs_id
INNER JOIN kfl_production_dbp_view.v_ma_spr_zu AS v03
  ON v02.mandant_id = v03.mandant_id
  AND v02.gl_vertrieb_id = v03.ma_id
  AND v03.spr_id = 22;
