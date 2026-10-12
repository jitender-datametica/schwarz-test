CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_STATUS as
   -- LOOKUP/SPRACHE Geschenkkarten Status [Transaktion]
   -- 2010KW17 GSS Redesign + Rollout KMO
   -- 2011KW37: Internationaliserung (feste Sprache)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   mandant_id, transaktion_id   --> Status
   , MAX(CASE WHEN spr_id =   22 THEN transaktion_bez ELSE NULL END)    AS transaktion_bez          --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN transaktion_bez ELSE NULL END)    AS transaktion_bez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN transaktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN transaktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN transaktion_bez ELSE NULL END)
   END  AS transaktion_bez_cz                    --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN transaktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN transaktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN transaktion_bez ELSE NULL END)
   END  AS transaktion_bez_pl                    --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN transaktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN transaktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN transaktion_bez ELSE NULL END)
   END  AS transaktion_bez_sk                    --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN transaktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN transaktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN transaktion_bez ELSE NULL END)
   END  AS transaktion_bez_hr                    --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN transaktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN transaktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN transaktion_bez ELSE NULL END)
   END  AS transaktion_bez_ro                    --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN transaktion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN transaktion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN transaktion_bez ELSE NULL END)
   END  AS transaktion_bez_bg                    --bulgarisch
   FROM dbp_view.v_transaktion_spr_zu  v01
   WHERE
   mandant_id<>1
   OR  transaktion_id <> 18     --  Transaktion18 war lediglich in DE-View ausgeklammert
   GROUP BY
   mandant_id
   ,transaktion_id;