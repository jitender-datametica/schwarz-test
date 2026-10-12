CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EREIGNISTYP_SPR_ZU as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   ereignistyp_id, mandant_id, MAX(CASE WHEN spr_id = 22 THEN ereignistyp_bez ELSE NULL END)    AS ereignistyp_bez    --standard=deutsch
   , MAX(CASE WHEN spr_id = 22 THEN ereignistyp_bez ELSE NULL END)    AS ereignistyp_bez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ereignistyp_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ereignistyp_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignistyp_bez ELSE NULL END)
   END  AS ereignistyp_bez_cz                  --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ereignistyp_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ereignistyp_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignistyp_bez ELSE NULL END)
   END  AS ereignistyp_bez_pl                  --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ereignistyp_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ereignistyp_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignistyp_bez ELSE NULL END)
   END  AS ereignistyp_bez_sk                  --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ereignistyp_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ereignistyp_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignistyp_bez ELSE NULL END)
   END  AS ereignistyp_bez_hr                  --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ereignistyp_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ereignistyp_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignistyp_bez ELSE NULL END)
   END  AS ereignistyp_bez_ro                  --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ereignistyp_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ereignistyp_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ereignistyp_bez ELSE NULL END)
   END  AS ereignistyp_bez_bg                  --bulgarisch
   FROM dbp_view.v_ereignistyp_spr_zu
   GROUP BY
   ereignistyp_id
   ,mandant_id;