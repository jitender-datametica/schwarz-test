CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_DWH_ARTIKEL_SPR_ZU_2 as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   -- 25.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel_2 um kmr_quelle_id ergänzt für Zusammenführung Hierarchie

   SELECT
   geku_dwh_artikel_id, geku_artikel_uid, 3 AS kmr_quelle_id, MAX(CASE WHEN spr_id = 22 THEN geku_dwh_artikel_bez ELSE NULL END) AS geku_dwh_artikel_bez     --standard=deutsch
   , MAX(CASE WHEN spr_id = 22 THEN geku_dwh_artikel_bez ELSE NULL END) AS geku_dwh_artikel_bez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_bez_cz      --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_bez_pl    --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_bez_sk    -- slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_bez_hr    -- kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  geku_dwh_artikel_bez_ro    --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN geku_dwh_artikel_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN geku_dwh_artikel_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_dwh_artikel_bez ELSE NULL END)
   END  AS geku_dwh_artikel_bez_bg    --bulgarisch
   FROM dbp_view.v_geku_dwh_artikel_spr_zu_2
   GROUP BY
   geku_dwh_artikel_id,geku_artikel_uid;