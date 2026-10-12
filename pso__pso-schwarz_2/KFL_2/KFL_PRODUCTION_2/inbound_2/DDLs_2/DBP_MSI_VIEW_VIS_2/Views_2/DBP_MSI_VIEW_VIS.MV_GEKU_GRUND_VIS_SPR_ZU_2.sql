CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_GRUND_VIS_SPR_ZU_2 as
   -- Sprach Lookup für GEKU Grund VIS
   -- 2012KW25 TB INITIAL
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   -- 20160229 UNION / VIS GRUND entfernt!

   SELECT
   geku_grund_uid  AS geku_grund_vis_id, MAX(CASE WHEN spr_id =   22 THEN geku_grund_bez ELSE NULL END)    AS geku_grund_vis_bez        --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN geku_grund_bez ELSE NULL END)    AS geku_grund_vis_bez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN geku_grund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN geku_grund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_grund_bez ELSE NULL END)
   END  AS geku_grund_vis_bez_cz             --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN geku_grund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN geku_grund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_grund_bez ELSE NULL END)
   END  AS geku_grund_vis_bez_pl           --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN geku_grund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN geku_grund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_grund_bez ELSE NULL END)
   END  AS geku_grund_vis_bez_sk           --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN geku_grund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN geku_grund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_grund_bez ELSE NULL END)
   END  AS geku_grund_vis_bez_hr           --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN geku_grund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN geku_grund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_grund_bez ELSE NULL END)
   END  AS geku_grund_vis_bez_ro           --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN geku_grund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN geku_grund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_grund_bez ELSE NULL END)
   END  AS geku_grund_vis_bez_bg           --bulgarisch

   FROM dbp_view.v_geku_grund_spr_zu_2
   GROUP BY geku_grund_uid

   /* UNION ALL
   SELECT
   -99      AS geku_grund_vis_id
   ,'Beschwerden Verteilung'     AS geku_grund_vis_bez
   ,'Beschwerden Verteilung'     AS geku_grund_vis_bez_de
   ,_UNICODE '0053007400ED017E006E006F0073007400690020006E006100200064006900730074007200690062007500630069'XCV      AS geku_grund_vis_bez_cz
   ,'Skargi na dystrybucje'     AS geku_grund_vis_bez_pl
   ,_UNICODE '005300740061017E006E006F0073007400690020006E00610020006400690073007400720069006200FA006300690075'XCV  AS geku_grund_vis_bez_sk
   ,_UNICODE '0052006100730070006F0064006A0065006C0061002000700072006900740075017E00620069'XCV        AS geku_grund_vis_bez_hr
   ,'Reclamatii Distributie'     AS geku_grund_vis_bez_ro
   ,_UNICODE '043E043F043B0430043A04320430043D0438044F0020044004300437043F0440043E0441044204400430043D0435043D04380435'XCV AS geku_grund_vis_bez_bg
   FROM
   dbp_view.v_tag_2
   WHERE
   dat = DATE */
   ;