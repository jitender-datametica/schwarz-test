CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_spr_zu AS SELECT mandant_id,
 art_id,
 kl_art_nr,
 art_bez,
 art_bez AS art_bez_de,
 COALESCE(a0, art_bez) AS art_bez_cz,
 COALESCE(a0_0, art_bez) AS art_bez_sk,
 COALESCE(a0_1, art_bez) AS art_bez_hr,
 COALESCE(a0_2, art_bez) AS art_bez_pl,
 COALESCE(a0_3, art_bez) AS art_bez_ro,
 COALESCE(a0_4, art_bez) AS art_bez_bg,
    art_bez || ' (' || kl_art_nr || ')' AS art_nr_bez,
    art_bez || ' (' || kl_art_nr || ')' AS art_nr_bez_de,
    COALESCE(a0, art_bez) || ' (' || kl_art_nr || ')' AS art_nr_bez_cz,
    COALESCE(a0_0, art_bez) || ' (' || kl_art_nr || ')' AS art_nr_bez_sk,
    COALESCE(a0_1, art_bez) || ' (' || kl_art_nr || ')' AS art_nr_bez_hr,
    COALESCE(a0_2, art_bez) || ' (' || kl_art_nr || ')' AS art_nr_bez_pl,
    COALESCE(a0_3, art_bez) || ' (' || kl_art_nr || ')' AS art_nr_bez_ro,
    COALESCE(a0_4, art_bez) || ' (' || kl_art_nr || ')' AS art_nr_bez_bg
FROM (SELECT mandant_id,
   art_id,
   TRIM(CAST(CASE
      WHEN mandant_id = 1
      THEN art_id / 100
      ELSE art_id / 10
      END AS STRING FORMAT '00000000')) AS kl_art_nr,
   MAX(CASE
     WHEN spr_id = 22
     THEN art_bez
     ELSE NULL
     END) AS art_bez,
   MAX(CASE
     WHEN spr_id = 124
     THEN art_bez
     ELSE NULL
     END) AS a0,
   MAX(CASE
     WHEN spr_id = 108
     THEN art_bez
     ELSE NULL
     END) AS a0_0,
   MAX(CASE
     WHEN spr_id = 65
     THEN art_bez
     ELSE NULL
     END) AS a0_1,
   MAX(CASE
     WHEN spr_id = 90
     THEN art_bez
     ELSE NULL
     END) AS a0_2,
   MAX(CASE
     WHEN spr_id = 95
     THEN art_bez
     ELSE NULL
     END) AS a0_3,
   MAX(CASE
     WHEN spr_id = 18
     THEN art_bez
     ELSE NULL
     END) AS a0_4
  FROM kfl_production_dbp_view.v_art_spr_zu AS V01
  GROUP BY mandant_id,
   art_id,
   kl_art_nr) AS t0;