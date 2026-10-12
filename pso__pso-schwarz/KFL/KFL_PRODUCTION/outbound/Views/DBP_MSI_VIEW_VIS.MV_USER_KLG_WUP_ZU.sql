CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_user_klg_wup_zu AS WITH USER_BM AS (SELECT LOWER(user_id) AS
   user_klg_id,
   mandant_id,
   hierarchie_element_id,
   LOWER(hierarchie_ebene_id) AS hierarchie_ebene_id,
   RIGHT(LOWER(user_id), 2) AS fil_user,
    CASE
    WHEN RIGHT(LOWER(user_id), 2) = 'hl'
    THEN 1
    WHEN RIGHT(LOWER(user_id), 2) = 'sv'
    THEN 2
    ELSE 0
    END AS klg_fg
  FROM kfl_production_dbp_msi_data.user_vis_benchmark_zu), WUP_BASIS AS (SELECT WD.mandant_id,
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
  FROM kfl_production_dbp_msi_data.wup_denorm AS WD
   INNER JOIN kfl_production_dbp_data.wup AS WP ON WD.mandant_id = WP.mandant_id AND WD.wup_id = WP.wup_id
  WHERE WP.nb_id IN (- 1, 0)
   AND WD.glv_land_id > 0), USER_WUP AS (SELECT LOWER(user_id) AS user_klg_id,
   mandant_id,
   wup_id
  FROM kfl_production_dbp_msi_data.user_wup_zu) (SELECT *
  FROM ((((((SELECT '010 HL (WBL)' AS rolle,
           ubm.user_klg_id,
           1 AS mein_bereich_fg,
           ubm.mandant_id,
           wup.wup_id
          FROM USER_BM AS ubm
           INNER JOIN WUP_BASIS AS wup ON ubm.mandant_id = wup.mandant_id AND ubm.hierarchie_element_id = wup.wup_id
          WHERE ubm.hierarchie_ebene_id = 'hl'
           AND ubm.klg_fg = 0
          UNION DISTINCT
          SELECT '020 VKL (HL)' AS rolle,
           ubm.user_klg_id,
           CAST(IF(ubm.hierarchie_element_id = wup.wup_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
           ubm.mandant_id,
           wup.wup_id
          FROM USER_BM AS ubm
           INNER JOIN WUP_BASIS AS klg ON ubm.mandant_id = klg.mandant_id AND ubm.hierarchie_element_id = klg.wup_id
           LEFT JOIN WUP_BASIS AS wup ON klg.mandant_id = wup.mandant_id AND klg.vkl_id = wup.vkl_id
          WHERE ubm.hierarchie_ebene_id = 'hl'
           AND ubm.klg_fg = 1)
         UNION DISTINCT
         SELECT '020 VKL (SV)' AS rolle,
          ubm.user_klg_id,
          CAST(IF(ubm.hierarchie_element_id = wup.wup_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
          ubm.mandant_id,
          wup.wup_id
         FROM USER_BM AS ubm
          INNER JOIN WUP_BASIS AS klg ON ubm.mandant_id = klg.mandant_id AND ubm.hierarchie_element_id = klg.wup_id
          LEFT JOIN WUP_BASIS AS wup ON klg.mandant_id = wup.mandant_id AND klg.vkl_id = wup.vkl_id
         WHERE ubm.hierarchie_ebene_id = 'hl'
          AND ubm.klg_fg = 2)
        UNION DISTINCT
        SELECT '030 GF (VKL)' AS rolle,
         ubm.user_klg_id,
         CAST(IF(ubm.hierarchie_element_id = wup.vkl_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
         ubm.mandant_id,
         wup.wup_id
        FROM USER_BM AS ubm
         INNER JOIN WUP_BASIS AS klg ON ubm.mandant_id = klg.mandant_id AND ubm.hierarchie_element_id = klg.vkl_id
         LEFT JOIN WUP_BASIS AS wup ON klg.mandant_id = wup.mandant_id AND klg.gf_id = wup.gf_id
        WHERE ubm.hierarchie_ebene_id = 'vkl')
       UNION DISTINCT
       SELECT '040 GL (GF)' AS rolle,
        ubm.user_klg_id,
        CAST(IF(ubm.hierarchie_element_id = wup.gf_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
        ubm.mandant_id,
        wup.wup_id
       FROM USER_BM AS ubm
        INNER JOIN WUP_BASIS AS klg ON ubm.mandant_id = klg.mandant_id AND ubm.hierarchie_element_id = klg.gf_id
        LEFT JOIN WUP_BASIS AS wup ON klg.mandant_id = wup.mandant_id AND klg.vs_id = wup.vs_id
       WHERE ubm.hierarchie_ebene_id = 'gf')
      UNION DISTINCT
      SELECT '050 GLV (GL)' AS rolle,
       ubm.user_klg_id,
       CAST(IF(ubm.hierarchie_element_id = wup.vs_id, 1, 0) AS BIGNUMERIC) AS mein_bereich_fg,
       ubm.mandant_id,
       wup.wup_id
      FROM USER_BM AS ubm
       LEFT JOIN WUP_BASIS AS wup ON ubm.mandant_id = wup.mandant_id
      WHERE ubm.hierarchie_ebene_id = 'vs')
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