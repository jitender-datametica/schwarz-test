CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WTAG_SPR_ZU as
   --ZEIT-Hierachie Wochentag
   --2009KW47: Initial
   --2011KW37: Internationaliserung (feste Sprache)
   --2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.wtag_id, MAX(CASE WHEN spr_id =   22 THEN wtag_bez ELSE NULL END)             AS wtag_bez --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)     AS wtag_kbez  --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN wtag_bez ELSE NULL END)             AS wtag_bez_de  --deutsch
   , MAX(CASE WHEN spr_id =   22 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)     AS wtag_kbez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN wtag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN wtag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN wtag_bez ELSE NULL END)
   END  AS wtag_bez_cz                         --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   END::VARCHAR(20) AS wtag_kbez_cz                       --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN wtag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN wtag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN wtag_bez ELSE NULL END)
   END  AS wtag_bez_pl                         --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   END::VARCHAR(20) AS wtag_kbez_pl                     --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN wtag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN wtag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN wtag_bez ELSE NULL END)
   END  AS wtag_bez_sk                         --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   END::VARCHAR(20) AS wtag_kbez_sk                     --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN wtag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN wtag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN wtag_bez ELSE NULL END)
   END  AS wtag_bez_hr                         --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   END::VARCHAR(20) AS wtag_kbez_hr                     --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN wtag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN wtag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN wtag_bez ELSE NULL END)
   END  AS wtag_bez_ro                         --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   END::VARCHAR(20) AS wtag_kbez_ro                     --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN wtag_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN wtag_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN wtag_bez ELSE NULL END)
   END  AS wtag_bez_bg                         --bulgarisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN TRIM(SUBSTRING(v01.wtag_bez, 1, 2)) ELSE NULL END)
   END::VARCHAR(20) AS wtag_kbez_bg                     --bulgarisch
   FROM dbp_view.v_wtag_spr_zu v01
   GROUP BY
   v01.wtag_id;