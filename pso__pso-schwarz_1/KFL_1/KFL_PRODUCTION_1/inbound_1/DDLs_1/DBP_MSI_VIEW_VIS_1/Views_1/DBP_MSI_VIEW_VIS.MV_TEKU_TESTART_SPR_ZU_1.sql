CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_TESTART_SPR_ZU_1 as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   CASE teku_attribut_id
   WHEN 43  THEN 1
   WHEN 297 THEN 0
   END AS frische_fg, MAX(CASE WHEN spr_id =  22 THEN teku_attribut_bez ELSE NULL END) AS  frische_fg_bez      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN teku_attribut_bez ELSE NULL END) AS  frische_fg_bez_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN teku_attribut_bez ELSE NULL END) AS  frische_fg_bez_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN teku_attribut_bez ELSE NULL END) AS  frische_fg_bez_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN teku_attribut_bez ELSE NULL END) AS  frische_fg_bez_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN teku_attribut_bez ELSE NULL END) AS  frische_fg_bez_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN teku_attribut_bez ELSE NULL END) AS  frische_fg_bez_ro   --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN teku_attribut_bez ELSE NULL END) AS  frische_fg_bez_bg   --bulgarisch
   FROM dbp_msi_v_view.v_l_teku_attribut_1
   WHERE
   teku_attribut_id IN (43, 297)
   GROUP BY
   CASE teku_attribut_id
   WHEN 43  THEN 1
   WHEN 297 THEN 0
   END;