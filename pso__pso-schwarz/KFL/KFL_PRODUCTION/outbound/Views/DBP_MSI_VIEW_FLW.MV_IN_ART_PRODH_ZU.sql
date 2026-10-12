CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_in_art_prodh_zu (mandant_id, in_art_id, prodh_lvl_1,
prodh_lvl_2, prodh_lvl_3, prodh_lvl_4, prodh_lvl_5, prodh_lvl_6, prodh_kompl) AS SELECT mandant_id,
 flw_art_id AS in_art_id,
 MAX(CASE
   WHEN flw_art_col_id = 1
   THEN art_col_auspr
   ELSE NULL
   END) AS prodh_lvl_1,
 MAX(CASE
   WHEN flw_art_col_id = 2
   THEN art_col_auspr
   ELSE NULL
   END) AS prodh_lvl_2,
 MAX(CASE
   WHEN flw_art_col_id = 3
   THEN art_col_auspr
   ELSE NULL
   END) AS prodh_lvl_3,
 MAX(CASE
   WHEN flw_art_col_id = 4
   THEN art_col_auspr
   ELSE NULL
   END) AS prodh_lvl_4,
 MAX(CASE
   WHEN flw_art_col_id = 5
   THEN art_col_auspr
   ELSE NULL
   END) AS prodh_lvl_5,
 MAX(CASE
   WHEN flw_art_col_id = 6
   THEN art_col_auspr
   ELSE NULL
   END) AS prodh_lvl_6,
      SUBSTR(CAST(MAX(CASE
          WHEN flw_art_col_id = 1
          THEN art_col_auspr
          ELSE NULL
          END) AS STRING), 1, 5) || SUBSTR(CAST(MAX(CASE
          WHEN flw_art_col_id = 2
          THEN art_col_auspr
          ELSE NULL
          END) AS STRING), 1, 2) || SUBSTR(CAST(MAX(CASE
         WHEN flw_art_col_id = 3
         THEN art_col_auspr
         ELSE NULL
         END) AS STRING), 1, 2) || SUBSTR(CAST(MAX(CASE
        WHEN flw_art_col_id = 4
        THEN art_col_auspr
        ELSE NULL
        END) AS STRING), 1, 2) || SUBSTR(CAST(MAX(CASE
       WHEN flw_art_col_id = 5
       THEN art_col_auspr
       ELSE NULL
       END) AS STRING), 1, 2) || SUBSTR(CAST(MAX(CASE
      WHEN flw_art_col_id = 6
      THEN art_col_auspr
      ELSE NULL
      END) AS STRING), 1, 2) AS prodh_kompl
FROM kfl_production_dbp_view.v_flw_art_col_zu
GROUP BY mandant_id,
 in_art_id;