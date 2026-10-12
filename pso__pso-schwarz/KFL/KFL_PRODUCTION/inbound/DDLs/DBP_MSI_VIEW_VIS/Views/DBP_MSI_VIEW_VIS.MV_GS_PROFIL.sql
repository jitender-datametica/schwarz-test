CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_PROFIL as
   -- LOOKUP/SPRACHE Profil
   -- 2010KW17 GSS Redesign + Rollout KMO
   -- 2011KW37: Internationaliserung (feste Sprache)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   mandant_id, profil_id, MAX(CASE WHEN spr_id =   22 THEN profil_bez ELSE NULL END)    AS profil_bez    --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN profil_bez ELSE NULL END)    AS profil_bez_de   --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN profil_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN profil_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN profil_bez ELSE NULL END)
   END  AS profil_bez_cz                   --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN profil_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN profil_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN profil_bez ELSE NULL END)
   END  AS profil_bez_pl                 --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN profil_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN profil_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN profil_bez ELSE NULL END)
   END  AS profil_bez_sk                 --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN profil_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN profil_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN profil_bez ELSE NULL END)
   END  AS profil_bez_hr                 --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN profil_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN profil_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN profil_bez ELSE NULL END)
   END  AS profil_bez_ro                 --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN profil_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN profil_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN profil_bez ELSE NULL END)
   END  AS profil_bez_bg                 --bulgarisch
   FROM dbp_view.v_profil_spr_zu  v01
   GROUP BY
   mandant_id
   ,profil_id;