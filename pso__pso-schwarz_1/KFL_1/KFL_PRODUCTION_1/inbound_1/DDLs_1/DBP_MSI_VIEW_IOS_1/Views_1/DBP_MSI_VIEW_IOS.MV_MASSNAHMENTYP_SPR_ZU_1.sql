CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_MASSNAHMENTYP_SPR_ZU_1 as
   -- Faktview : Massnahmengruppe gemäß: AP0004980
   -- 20161202 kkai0912 : initial
   -- 20180223 nfis0811: Erweiterung für (Spalten)-Internationalisierung
   SELECT
   v01.massnahmentyp_id, MAX(CASE WHEN v02.spr_id =  22 THEN -- standard == DE;
   CASE WHEN v02.massnahmentyp_id = '-1' THEN '  '
   ELSE v02.massnahmentyp_bez
   END
   ELSE NULL END) AS massnahmentyp_bez, COALESCE(MAX(CASE WHEN v02.spr_id = 124 AND v02.massnahmentyp_id <> '-1' THEN v02.massnahmentyp_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN
   CASE WHEN v02.massnahmentyp_id = '-1' THEN '  '
   ELSE v02.massnahmentyp_bez
   END
   ELSE NULL END)) AS massnahmentyp_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 AND v02.massnahmentyp_id <> '-1' THEN v02.massnahmentyp_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN
   CASE WHEN v02.massnahmentyp_id = '-1' THEN '  '
   ELSE v02.massnahmentyp_bez
   END
   ELSE NULL END)) AS massnahmentyp_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65 AND v02.massnahmentyp_id <> '-1' THEN v02.massnahmentyp_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN
   CASE WHEN v02.massnahmentyp_id = '-1' THEN '  '
   ELSE v02.massnahmentyp_bez
   END
   ELSE NULL END)) AS massnahmentyp_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90 AND v02.massnahmentyp_id <> '-1' THEN v02.massnahmentyp_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN
   CASE WHEN v02.massnahmentyp_id = '-1' THEN '  '
   ELSE v02.massnahmentyp_bez
   END
   ELSE NULL END)) AS massnahmentyp_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95 AND v02.massnahmentyp_id <> '-1' THEN v02.massnahmentyp_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN
   CASE WHEN v02.massnahmentyp_id = '-1' THEN '  '
   ELSE v02.massnahmentyp_bez
   END
   ELSE NULL END)) AS massnahmentyp_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id =  24 AND v02.massnahmentyp_id <> '-1' THEN v02.massnahmentyp_bez ELSE NULL END),MAX(CASE WHEN v02.spr_id =  22 THEN
   CASE WHEN v02.massnahmentyp_id = '-1' THEN '  '
   ELSE v02.massnahmentyp_bez
   END
   ELSE NULL END)) AS massnahmentyp_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18 AND v02.massnahmentyp_id <> '-1' THEN v02.massnahmentyp_bez ELSE NULL END) ,MAX(CASE WHEN v02.spr_id =  22 THEN
   CASE WHEN v02.massnahmentyp_id = '-1' THEN '  '
   ELSE v02.massnahmentyp_bez
   END
   ELSE NULL END)) AS massnahmentyp_bez_bg    -- BG

   FROM dbp_view.v_l_massnahmentyp_1 v01
   JOIN dbp_view.v_massnahmentyp_spr_zu_1 v02
   ON v01.massnahmentyp_id = v02.massnahmentyp_id
   --AND v02.spr_id = 22;

   GROUP BY
   v01.massnahmentyp_id;