CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_GF
AS
   SELECT
   mandant_id, gf_id, ek_fg, gf_name

   /*
   --standard=deutsch
   ,MAX(CASE WHEN spr_id = 22 THEN ma_anrede	ELSE NULL END)      AS ma_anrede
   ,MAX(CASE WHEN spr_id = 22 THEN ma_vorname ELSE NULL END)      AS ma_vorname
   ,MAX(CASE WHEN spr_id = 22 THEN ma_name		ELSE NULL END)      AS ma_name
   ,MAX(CASE WHEN spr_id = 22 THEN ma_name		ELSE NULL END)  (VARCHAR(40))  AS gf_name

   --deutsch
   ,MAX(CASE WHEN spr_id = 22 THEN ma_anrede	ELSE NULL END)      AS ma_anrede_de
   ,MAX(CASE WHEN spr_id = 22 THEN ma_vorname	ELSE NULL END)      AS ma_vorname_de
   ,MAX(CASE WHEN spr_id = 22 THEN ma_name		ELSE NULL END)      AS ma_name_de
   ,MAX(CASE WHEN spr_id = 22 THEN ma_name		ELSE NULL END)  (VARCHAR(40))  AS gf_name_de

   --tschechisch
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_anrede ELSE NULL END)
   END  AS ma_anrede_cz
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_vorname ELSE NULL END)
   END  AS ma_vorname_cz
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name ELSE NULL END)
   END  AS ma_name_cz
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ma_name  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ma_name  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name  ELSE NULL END)
   END (VARCHAR(40)) AS gf_name_cz

   --polnisch
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_anrede ELSE NULL END)
   END  AS ma_anrede_pl
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_vorname ELSE NULL END)
   END  AS ma_vorname_pl
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name ELSE NULL END)
   END  AS ma_name_pl
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ma_name  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ma_name  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name  ELSE NULL END)
   END (VARCHAR(40)) AS gf_name_pl

   --slowakisch
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_anrede ELSE NULL END)
   END  AS ma_anrede_sk
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_vorname ELSE NULL END)
   END  AS ma_vorname_sk
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name ELSE NULL END)
   END  AS ma_name_sk
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ma_name  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ma_name  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name  ELSE NULL END)
   END (VARCHAR(40)) AS gf_name_sk

   --kroatisch
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_anrede ELSE NULL END)
   END  AS ma_anrede_hr
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_vorname ELSE NULL END)
   END  AS ma_vorname_hr
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name ELSE NULL END)
   END  AS ma_name_hr
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ma_name  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ma_name  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name  ELSE NULL END)
   END (VARCHAR(40)) AS gf_name_hr

   --rumänisch
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_anrede ELSE NULL END)
   END  AS ma_anrede_ro
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_vorname ELSE NULL END)
   END  AS ma_vorname_ro
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name ELSE NULL END)
   END  AS ma_name_ro
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ma_name  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ma_name  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name  ELSE NULL END)
   END (VARCHAR(40)) AS gf_name_ro

   --bulgarisch
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_anrede ELSE NULL END)
   END  AS ma_anrede_bg
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_vorname ELSE NULL END)
   END  AS ma_vorname_bg
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name ELSE NULL END)
   END  AS ma_name_bg
   ,CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ma_name  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ma_name  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_name  ELSE NULL END)
   END (VARCHAR(40)) AS gf_name_bg

   FROM  dbp_view.v_ma_spr_zu

   WHERE
   (mandant_id, ma_id) IN
   (
   SELECT mandant_id, (1000 + mandant_id * 100 + vs_id * 10) * -1 (INTEGER)
   FROM dbp_view.v_vs
   )
   GROUP BY
   mandant_id
   ,ma_id;

   */

   FROM
   dbp_view.v_gf
   WHERE ek_fg = 1;