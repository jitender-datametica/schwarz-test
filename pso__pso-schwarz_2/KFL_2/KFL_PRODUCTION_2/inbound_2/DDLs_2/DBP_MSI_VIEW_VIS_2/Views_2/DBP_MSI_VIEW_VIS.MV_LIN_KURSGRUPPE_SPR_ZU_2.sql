CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_LIN_KURSGRUPPE_SPR_ZU_2 as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v1.mandant_id, v1.lin_kursgruppe_id, MAX(CASE WHEN v2.spr_id =  22 THEN v2.lin_kursgruppe_bez ELSE NULL END)  AS lin_kursgruppe_bez      --standard=deutsch
   , MAX(CASE WHEN v2.spr_id =  22 THEN v2.lin_kursgruppe_bez ELSE NULL END)  AS lin_kursgruppe_bez_de   --deutsch
   , MAX(CASE WHEN v2.spr_id = 124 THEN v2.lin_kursgruppe_bez ELSE NULL END)  AS lin_kursgruppe_bez_cz   --tschechisch
   , MAX(CASE WHEN v2.spr_id =  90 THEN v2.lin_kursgruppe_bez ELSE NULL END)  AS lin_kursgruppe_bez_pl   --polnisch
   , MAX(CASE WHEN v2.spr_id = 108 THEN v2.lin_kursgruppe_bez ELSE NULL END)  AS lin_kursgruppe_bez_sk   --slowakisch
   , MAX(CASE WHEN v2.spr_id =  65 THEN v2.lin_kursgruppe_bez ELSE NULL END)  AS lin_kursgruppe_bez_hr   --kroatisch
   , MAX(CASE WHEN v2.spr_id =  95 THEN v2.lin_kursgruppe_bez ELSE NULL END)  AS lin_kursgruppe_bez_ro   --rumänisch
   , MAX(CASE WHEN v2.spr_id =  18 THEN v2.lin_kursgruppe_bez ELSE NULL END)  AS lin_kursgruppe_bez_bg   --bulgarisch
   FROM dbp_view.v_l_lin_kursgruppe_2   v1
   INNER JOIN dbp_view.v_lin_kursgruppe_spr_zu_2  v2
   ON v1.lin_kursgruppe_id = v2.lin_kursgruppe_id
   GROUP BY
   1,2;