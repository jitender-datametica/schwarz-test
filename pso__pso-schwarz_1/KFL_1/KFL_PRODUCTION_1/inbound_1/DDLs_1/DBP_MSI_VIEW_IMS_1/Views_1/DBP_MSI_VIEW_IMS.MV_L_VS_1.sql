CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_VS_1 AS
-- 14.06.2013 twie: Kopie aus VIS mv_vs_1
-- 23.04.2014 twie: Geänderte Wherebedingung aus VIS übernommen

   SELECT
   v01.mandant_id,
   v01.vs_id,
   v03.ma_anrede,
   -- Dummy_1 gibt es nur für DE
   CASE WHEN v01.vs_id = 0 AND v01.mandant_id = 1 THEN ''
   ELSE v03.ma_name
   END AS ma_name,
   v03.ma_vorname
  -- not used
  /*, v01.vk_id
  , v01.vs_bez
  , v01.vsvt_bez AS vsvt_bez*/
  FROM
   dbp_view.v_vs_1 v01

   JOIN (
   SELECT DISTINCT
   w.mandant_id,
   w.vs_id,
   MAX(wd.gl_vertrieb_id) OVER (PARTITION BY w.mandant_id, w.vs_id) AS gl_vertrieb_id
  FROM dbp_view.v_wup_1 w
   LEFT JOIN dbp_msi_v_view.v_wup_denorm_1 wd
   ON w.mandant_id = wd.mandant_id
   AND w.wup_id=wd.wup_id

   WHERE w.nb_id IN (-2, -1, 0)
   AND dat_eroeffnung <  '9999-12-31' -- NUR belannte eroeffnungen
   AND dat_bis =  '9999-12-31'-- OHNE schliessungen
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.vs_id = v02.vs_id

   JOIN dbp_view.v_ma_spr_zu_1 v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.gl_vertrieb_id = v03.ma_id
   AND v03.spr_id=22;