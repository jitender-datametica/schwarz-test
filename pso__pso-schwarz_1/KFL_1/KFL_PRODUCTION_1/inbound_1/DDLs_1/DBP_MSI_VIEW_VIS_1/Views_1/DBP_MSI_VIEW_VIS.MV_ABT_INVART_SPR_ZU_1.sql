CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABT_INVART_SPR_ZU_1 as
   -- SPRACHE/LOOKUP : Inventurart im Reporting (pro Abteilung)
   -- 2018.1128 ssch0611 : Initial - Umstellung OWG
   -- 2019.0121 ssch0611 : Update Bezeichnungen

   SELECT DISTINCT
   aiz.abt_invart_id, MAX(CASE WHEN abt.spr_id = 22 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez || ' (' || abt_bez || ')'
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN abt_bez || ' OWG'
   ELSE abt_bez || ' ' || inventurart_int_bez
   END END) AS abt_invart_bez, MAX(CASE WHEN abt.spr_id = 124 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez|| ' (' || abt_bez || ')'
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN abt_bez || ' OWG'
   ELSE abt_bez || ' ' || inventurart_int_bez
   END END) AS abt_invart_bez_cz, MAX(CASE WHEN abt.spr_id = 108 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez || ' (' || abt_bez || ')'
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN abt_bez || ' OWG'
   ELSE abt_bez || ' ' || inventurart_int_bez
   END END) AS abt_invart_bez_sk, MAX(CASE WHEN abt.spr_id =  65 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez || ' (' || abt_bez || ')'
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN abt_bez || ' OWG'
   ELSE abt_bez || ' ' || inventurart_int_bez
   END END) AS abt_invart_bez_hr, MAX(CASE WHEN abt.spr_id =  90 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez || ' (' || abt_bez || ')'
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN abt_bez || ' NGT' -- Uebersetzung in PL
   ELSE abt_bez || ' ' || inventurart_int_bez
   END END) AS abt_invart_bez_pl, MAX(CASE WHEN abt.spr_id =  95 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez || ' (' || abt_bez || ')'
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN abt_bez || ' OWG'
   ELSE abt_bez || ' ' || inventurart_int_bez
   END END) AS abt_invart_bez_ro, MAX(CASE WHEN abt.spr_id =  18 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez || ' (' || abt_bez || ')'
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN abt_bez || ' OWG'
   ELSE abt_bez || ' ' || inventurart_int_bez
   END END) AS abt_invart_bez_bg, abt_invart_bez AS abt_invart_bez_de, MAX(CASE WHEN abt.spr_id = 22 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS invart_bez, MAX(CASE WHEN abt.spr_id = 124 THEN CASE
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS invart_bez_cz, MAX(CASE WHEN abt.spr_id = 108 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS invart_bez_sk, MAX(CASE WHEN abt.spr_id =  65 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS invart_bez_hr, MAX(CASE WHEN abt.spr_id =  90 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN 'NGT'
   ELSE inventurart_int_bez
   END END) AS invart_bez_pl, MAX(CASE WHEN abt.spr_id =  95 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS invart_bez_ro, MAX(CASE WHEN abt.spr_id =  18 THEN CASE
   WHEN aiz.abt_invart_id BETWEEN 90 AND 99 THEN inventurart_int_bez
   WHEN aiz.abt_invart_id = 50 THEN abt_bez
   WHEN aiz.abt_invart_id IN (43, 63, 73, 83) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS invart_bez_bg, invart_bez AS invart_bez_de
   FROM dbp_msi_view_vis.mv_abt_inventurart_int_zu_1 aiz

   JOIN dbp_view.v_abt_spr_zu_1 abt_1
   ON aiz.abt_id = abt.abt_id

   JOIN dbp_view.v_inventurart_int_spr_zu_1 inv
   ON aiz.inventurart_int_id = inv.inventurart_int_id
   AND abt.spr_id = inv.spr_id

   GROUP BY abt_invart_id
   ;