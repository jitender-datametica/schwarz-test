CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_werbecluster_vz
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id AS mandant_id,
  kjwo AS kjwo,
  wup_id AS vz_wup_id,
  nb_id AS vz_nb_id,
  wg_id AS wg_id,
  art_id AS art_id,
  faktura_menge_sa_ww AS faktura_menge_sa_ww,
  faktura_menge_sa_1vw AS faktura_menge_sa_1vw,
  faktura_menge_sa_ww_vw AS faktura_menge_sa_ww_vw,
  faktura_menge_af_6vw AS faktura_menge_af_6vw,
  werbecluster AS werbecluster,
  faktura_menge_af_1fw AS faktura_menge_af_1fw,
  normalcluster_1fw AS normalcluster_1fw,
  faktura_menge_af_2fw AS faktura_menge_af_2fw,
  normalcluster_2fw AS normalcluster_2fw,
  faktura_menge_af_3fw AS faktura_menge_af_3fw,
  normalcluster_3fw AS normalcluster_3fw,
  faktura_menge_sa_ww_wg AS faktura_menge_sa_ww_wg,
  faktura_menge_sa_1vw_wg AS faktura_menge_sa_1vw_wg,
  faktura_menge_sa_ww_1vw_wg AS faktura_menge_sa_ww_1vw_wg,
  faktura_menge_af_6vw_wg AS faktura_menge_af_6vw_wg,
  werbecluster_wg AS werbecluster_wg,
  faktura_menge_af_1fw_wg AS faktura_menge_af_1fw_wg,
  normalcluster_1fw_wg AS normalcluster_1fw_wg,
  faktura_menge_af_2fw_wg AS faktura_menge_af_2fw_wg,
  normalcluster_2fw_wg AS normalcluster_2fw_wg,
  faktura_menge_af_3fw_wg AS faktura_menge_af_3fw_wg,
  normalcluster_3fw_wg AS normalcluster_3fw_wg,
  MAX(werbecluster) OVER (
    PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS max_werbecluster,
  max_werbecluster_new AS max_werbecluster_new,
  MIN(werbecluster) OVER (
    PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS min_werbecluster,
  min_werbecluster_new AS min_werbecluster_new
FROM (
  SELECT
    mandant_id,
    kjwo,
    wup_id,
    nb_id,
    wg_id,
    art_id,
    faktura_menge_sa_ww,
    faktura_menge_sa_1vw,
    CAST(faktura_menge_sa_ww + faktura_menge_sa_1vw AS NUMERIC) AS faktura_menge_sa_ww_vw,
    faktura_menge_af_6vw,
    CASE
      WHEN faktura_menge_af_6vw > 0
      THEN CAST(faktura_menge_sa_ww + faktura_menge_sa_1vw AS NUMERIC) / faktura_menge_af_6vw
      ELSE NULL
    END AS werbecluster,
    MAX(
      CASE
        WHEN faktura_menge_af_6vw > 0
        THEN CAST(faktura_menge_sa_ww + faktura_menge_sa_1vw AS NUMERIC) / faktura_menge_af_6vw
        ELSE NULL
      END
    ) OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS max_werbecluster_new,
    MIN(
      CASE
        WHEN faktura_menge_af_6vw > 0
        THEN CAST(faktura_menge_sa_ww + faktura_menge_sa_1vw AS NUMERIC) / faktura_menge_af_6vw
        ELSE NULL
      END
    ) OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS min_werbecluster_new,
    faktura_menge_af_1fw,
    CASE
      WHEN faktura_menge_af_6vw > 0
      THEN CAST(faktura_menge_af_1fw AS NUMERIC) / faktura_menge_af_6vw
      ELSE NULL
    END AS normalcluster_1fw,
    faktura_menge_af_2fw,
    CASE
      WHEN faktura_menge_af_6vw > 0
      THEN CAST(faktura_menge_af_2fw AS NUMERIC) / faktura_menge_af_6vw
      ELSE NULL
    END AS normalcluster_2fw,
    faktura_menge_af_3fw,
    CASE
      WHEN faktura_menge_af_6vw > 0
      THEN CAST(faktura_menge_af_3fw AS NUMERIC) / faktura_menge_af_6vw
      ELSE NULL
    END AS normalcluster_3fw,
    SUM(faktura_menge_sa_ww) OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS faktura_menge_sa_ww_wg,
    SUM(faktura_menge_sa_1vw) OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS faktura_menge_sa_1vw_wg,
    (
      SUM(faktura_menge_sa_ww) OVER (
        PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      )
    ) + (
      SUM(faktura_menge_sa_1vw) OVER (
        PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      )
    ) AS faktura_menge_sa_ww_1vw_wg,
    SUM(faktura_menge_af_6vw) OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS faktura_menge_af_6vw_wg,
    CASE
      WHEN (
        SUM(faktura_menge_af_6vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      ) > 0
      THEN CAST((
        SUM(faktura_menge_sa_ww) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      ) + (
        SUM(faktura_menge_sa_1vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      ) AS NUMERIC) / (
        SUM(faktura_menge_af_6vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      )
      ELSE NULL
    END AS werbecluster_wg,
    SUM(faktura_menge_af_1fw) OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS faktura_menge_af_1fw_wg,
    CASE
      WHEN (
        SUM(faktura_menge_af_6vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      ) > 0
      THEN CAST(SUM(faktura_menge_af_1fw) OVER (
        PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) AS NUMERIC) / (
        SUM(faktura_menge_af_6vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      )
      ELSE NULL
    END AS normalcluster_1fw_wg,
    SUM(faktura_menge_af_2fw) OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS faktura_menge_af_2fw_wg,
    CASE
      WHEN (
        SUM(faktura_menge_af_6vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      ) > 0
      THEN CAST(SUM(faktura_menge_af_2fw) OVER (
        PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) AS NUMERIC) / (
        SUM(faktura_menge_af_6vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      )
      ELSE NULL
    END AS normalcluster_2fw_wg,
    SUM(faktura_menge_af_3fw) OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS faktura_menge_af_3fw_wg,
    CASE
      WHEN (
        SUM(faktura_menge_af_6vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      ) > 0
      THEN CAST(SUM(faktura_menge_af_3fw) OVER (
        PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) AS NUMERIC) / (
        SUM(faktura_menge_af_6vw) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      )
      ELSE NULL
    END AS normalcluster_3fw_wg
  FROM kfl_production_dbp_view.v_besch_faktura_werbecluster
) AS v11;
