CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_SHR_MA_FUNKTION_VERTRIEB_1 as
   SELECT
   sub.mandant_id, sub.shr_ma_funktion_id_2, MAX(sub.shr_ma_funktion_id_funktion) AS shr_ma_funktion_id_funktion

   FROM
   (SELECT
   v01.mandant_id, v01.shr_ma_funktion_id, CASE WHEN SUBSTRING(v01.shr_ma_funktion_id, 3, 1) = '-' THEN SUBSTRING(v01.shr_ma_funktion_id, 1, 2)
   ELSE '99' END AS shr_ma_funktion_id_2, CASE WHEN shr_ma_funktion_id_2 IN (11,12,13,14,15,16,21,22) THEN 'Ges' ELSE NULL END AS shr_ma_funktion_id_gesamt, CASE WHEN shr_ma_funktion_id_2 IN (14,15,16,21,22) THEN 'FE' ELSE NULL END AS shr_ma_funktion_id_f_ebene, CASE WHEN shr_ma_funktion_id_2 IN (11) THEN 'MA'
   WHEN shr_ma_funktion_id_2 IN (12) THEN 'MA'
   WHEN shr_ma_funktion_id_2 IN (13) THEN 'MA'
   WHEN shr_ma_funktion_id_2 IN (14) THEN 'Erstkraft'
   WHEN shr_ma_funktion_id_2 IN (15) THEN 'PSB'
   WHEN shr_ma_funktion_id_2 IN (16) THEN 'TL'
   WHEN shr_ma_funktion_id_2 IN (21) THEN 'WBL_1'
   WHEN shr_ma_funktion_id_2 IN (22) THEN 'HL_1' ELSE 'nicht zugeordnet' END AS shr_ma_funktion_id_funktion, v02.ma_funktion_bez

   FROM dbp_view.v_l_shr_ma_funktion_1 v01
   LEFT JOIN dbp_view.v_ma_funktion_spr_zu_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.shr_ma_funktion_id = v02.ma_funktion_id
   AND v02.spr_id = 22) sub
   GROUP BY 1,2;