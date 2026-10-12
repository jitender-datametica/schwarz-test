CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_KUM_SPR_ZU as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   CASE teku_attribut_id
   WHEN 351 THEN 1
   WHEN 396 THEN 2
   END::BYTEINT        AS kum_id, MAX(CASE WHEN spr_id =  22 THEN teku_attribut_bez ELSE NULL END) AS kum_bez     --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN teku_attribut_bez ELSE NULL END) AS kum_bez_de  --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN teku_attribut_bez ELSE NULL END) AS kum_bez_cz  --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN teku_attribut_bez ELSE NULL END) AS kum_bez_pl  --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN teku_attribut_bez ELSE NULL END) AS kum_bez_sk  --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN teku_attribut_bez ELSE NULL END) AS kum_bez_hr  --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN teku_attribut_bez ELSE NULL END) AS kum_bez_ro  --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN teku_attribut_bez ELSE NULL END) AS kum_bez_bg  --bulgarisch
   FROM dbp_msi_v_view.v_l_teku_attribut
   WHERE
   teku_attribut_id IN (351, 396)
   GROUP BY
   CASE teku_attribut_id
   WHEN 351 THEN 1
   WHEN 396 THEN 2
   END::BYTEINT;