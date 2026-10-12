CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_user_klg_wup_zu_1 AS WITH USER_BM AS (SELECT LOWER(user_id) AS
   user_klg_id,
   mandant_id,
   hierarchie_element_id,
   LOWER(hierarchie_ebene_id) AS hierarchie_ebene_id,
   RIGHT(LOWER(user_id), 2) AS fil_user,
    CASE
    WHEN RIGHT(LOWER(user_id), 2) = 'hl_1'
    THEN 1
    WHEN RIGHT(LOWER(user_id), 2) = 'sv'
    THEN 2
    ELSE 0
    END AS klg_fg
  FROM kfl_production_dbp_msi_data.user_vis_benchmark_zu_1), WUP_BASIS AS (SELECT WD.mandant_id,
   WD.wup_id,
   WP.vs_id,
   WP.land_id,
   WP.wup_standort,
   WP.dat_von,
   WP.dat_eroeffnung,
   WP.dat_bis,
   WD.vkl_id,
   WD.gf_gbl_vertrieb_id AS gf_id,
   WD.gl_vertrieb_id AS gl_id,
   WD.glv_land_id AS glv_id
  FROM kfl_production_dbp_msi_data.wup_denorm_1 AS WD
   INNER JOIN kfl_production_dbp_data.wup_1 AS WP ON WD.mandant_id = WP.mandant_id AND WD.wup_id = WP.wup_id
  WHERE WP.nb_id IN (- 1, 0)
   AND WD.glv_land_id > 0), USER_WUP AS (SELECT LOWER(user_id) AS user_klg_id,
   mandant_id,
   wup_id
  FROM kfl_production_dbp_msi_data.user_wup_zu_1) (SELECT *
  FROM ((((((SELECT '010 HL_1 (WBL_1)' AS rolle,
           ubm.user_klg_id,
           1 AS mein_bereich_fg,
           ubm.mandant_id,
           wup.wup_id
          FROM USER_BM AS ubm
           INNER JOIN WUP_BASIS AS wup_1 ON ubm.mandant_id = wup.mandant_id AND ubm.hierarchie_element_id = wup.wup_id
          WHERE ubm.hierarchie_ebene_id = 'hl_1'
           AND ubm.klg_fg = 0
          UNION DISTINCT
          SELECT '020 VKL_1 (HL_1)' AS rolle,
           ubm.user_klg_id,
           CAST(IF(ubm.hierarchie_element_id = wup.wup_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
           ubm.mandant_id,
           wup.wup_id
          FROM USER_BM AS ubm
           INNER JOIN WUP_BASIS AS klg ON ubm.mandant_id = klg.mandant_id AND ubm.hierarchie_element_id = klg.wup_id
           LEFT JOIN WUP_BASIS AS wup_1 ON klg.mandant_id = wup.mandant_id AND klg.vkl_id = wup.vkl_id
          WHERE ubm.hierarchie_ebene_id = 'hl_1'
           AND ubm.klg_fg = 1)
         UNION DISTINCT
         SELECT '020 VKL_1 (SV)' AS rolle,
          ubm.user_klg_id,
          CAST(IF(ubm.hierarchie_element_id = wup.wup_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
          ubm.mandant_id,
          wup.wup_id
         FROM USER_BM AS ubm
          INNER JOIN WUP_BASIS AS klg ON ubm.mandant_id = klg.mandant_id AND ubm.hierarchie_element_id = klg.wup_id
          LEFT JOIN WUP_BASIS AS wup_1 ON klg.mandant_id = wup.mandant_id AND klg.vkl_id = wup.vkl_id
         WHERE ubm.hierarchie_ebene_id = 'hl_1'
          AND ubm.klg_fg = 2)
        UNION DISTINCT
        SELECT '030 GF_1 (VKL_1)' AS rolle,
         ubm.user_klg_id,
         CAST(IF(ubm.hierarchie_element_id = wup.vkl_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
         ubm.mandant_id,
         wup.wup_id
        FROM USER_BM AS ubm
         INNER JOIN WUP_BASIS AS klg ON ubm.mandant_id = klg.mandant_id AND ubm.hierarchie_element_id = klg.vkl_id
         LEFT JOIN WUP_BASIS AS wup_1 ON klg.mandant_id = wup.mandant_id AND klg.gf_id = wup.gf_id
        WHERE ubm.hierarchie_ebene_id = 'vkl_1')
       UNION DISTINCT
       SELECT '040 GL (GF_1)' AS rolle,
        ubm.user_klg_id,
        CAST(IF(ubm.hierarchie_element_id = wup.gf_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
        ubm.mandant_id,
        wup.wup_id
       FROM USER_BM AS ubm
        INNER JOIN WUP_BASIS AS klg ON ubm.mandant_id = klg.mandant_id AND ubm.hierarchie_element_id = klg.gf_id
        LEFT JOIN WUP_BASIS AS wup_1 ON klg.mandant_id = wup.mandant_id AND klg.vs_id = wup.vs_id
       WHERE ubm.hierarchie_ebene_id = 'gf_1')
      UNION DISTINCT
      SELECT '050 GLV (GL)' AS rolle,
       ubm.user_klg_id,
       CAST(IF(ubm.hierarchie_element_id = wup.vs_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
       ubm.mandant_id,
       wup.wup_id
      FROM USER_BM AS ubm
       LEFT JOIN WUP_BASIS AS wup_1 ON ubm.mandant_id = wup.mandant_id
      WHERE ubm.hierarchie_ebene_id = 'vs_1')
     UNION DISTINCT
     SELECT IF(ubm.anz_land < 8, '050 NAT', '060 INT') AS rolle,
      uwz.user_klg_id,
      1 AS mein_bereich_fg,
      uwz.mandant_id,
      uwz.wup_id
     FROM USER_WUP AS uwz
      INNER JOIN (SELECT user_klg_id,
        COUNT(DISTINCT mandant_id) AS anz_land
       FROM USER_BM
       GROUP BY user_klg_id) AS ubm ON uwz.user_klg_id = ubm.user_klg_id));