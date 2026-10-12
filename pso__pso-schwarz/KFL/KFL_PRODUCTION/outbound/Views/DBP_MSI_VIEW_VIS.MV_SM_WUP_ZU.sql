CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sm_wup_zu (mandant_id, nb_id, vw_id, vw_kz, wup_id,
sm_fleisch_id, sm_wurst_sb_id, sm_wurst_bed_id, sm_kaese_bed_id, sm_fisch_bed_id, sm_obst_gem_id, sm_pflanzen_id,
sm_food_id, sm_nonfood_id, sm_fleisch_sb_bez, sm_fleisch_bed_bez, sm_wurst_sb_bez, sm_wurst_bed_bez, sm_kaese_bed_bez,
sm_fisch_bed_bez, sm_obst_gem_bez, sm_pflanzen_bez, sm_food_bez, sm_nonfood_bez) AS SELECT WP.mandant_id,
 WP.nb_id,
 WP.vw_id,
 CAST(WP.land_id AS STRING) AS vw_kz,
 WP.wup_id,
 sm.sm_fleisch_sb AS sm_fleisch_id,
 sm.sm_wurst_sb AS sm_wurst_sb_id,
 sm.sm_wurst_bed AS sm_wurst_bed_id,
 sm.sm_kaese_bed AS sm_kaese_bed_id,
 sm.sm_fisch_bed AS sm_fisch_bed_id,
 sm.sm_obst_gem AS sm_obst_gem_id,
 sm.sm_pflanzen AS sm_pflanzen_id,
 sm.sm_food AS sm_food_id,
 sm.sm_nonfood AS sm_nonfood_id,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_fleisch_sb, ' - ') AS sm_fleisch_sb_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_fleisch_bed, ' - ') AS sm_fleisch_bed_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_wurst_sb, ' - ') AS sm_wurst_sb_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_wurst_bed, ' - ') AS sm_wurst_bed_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_kaese_bed, ' - ') AS sm_kaese_bed_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_fisch_bed, ' - ') AS sm_fisch_bed_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_obst_gem, ' - ') AS sm_obst_gem_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_pflanzen, ' - ') AS sm_pflanzen_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_food, ' - ') AS sm_food_bez,
 COALESCE(CAST(WP.land_id AS STRING) || ' ' || sm.sm_nonfood, ' - ') AS sm_nonfood_bez
FROM kfl_production_dbp_msi_view_vis.mv_wup AS WP
 LEFT JOIN (SELECT wup_id,
   mandant_id,
   CAST(MAX(CASE
      WHEN wg_id = 128
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_fleisch_sb,
   CAST(MAX(CASE
      WHEN wg_id = 128
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_fleisch_bed,
   CAST(MAX(CASE
      WHEN wg_id = 136
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_wurst_sb,
   CAST(MAX(CASE
      WHEN wg_id = 136
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_wurst_bed,
   CAST(MAX(CASE
      WHEN wg_id = 129
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_kaese_bed,
   CAST(MAX(CASE
      WHEN wg_id = 179
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_fisch_bed,
   CAST(MAX(CASE
      WHEN wg_id = 161
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_obst_gem,
   CAST(MAX(CASE
      WHEN wg_id = 161
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_pflanzen,
   CAST(MAX(CASE
      WHEN wg_id = 0
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_food,
   CAST(MAX(CASE
      WHEN wg_id IN (0)
      THEN COALESCE(CAST(sm_id AS STRING), ksm_id)
      ELSE NULL
      END) AS STRING) AS sm_nonfood
  FROM kfl_production_dbp_view.v_sm_wup_wg_zu_per
  WHERE dat_bis = DATE '9999-12-31'
   AND arthiertyp_id = 2
   AND (sm_id >= 0 OR ksm_id IS NOT NULL)
  GROUP BY wup_id,
   mandant_id) AS sm ON WP.mandant_id = sm.mandant_id AND WP.wup_id = sm.wup_id;