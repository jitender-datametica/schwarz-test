CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_GRUND_SPR_ZU as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   sb_grund_id, mandant_id, MAX(CASE WHEN spr_id =  22 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_bez  --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_ro   --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_bg   --bulgarisch
   FROM dbp_view.v_sb_grund_spr_zu  v01
   GROUP BY
   sb_grund_id
   ,mandant_id;