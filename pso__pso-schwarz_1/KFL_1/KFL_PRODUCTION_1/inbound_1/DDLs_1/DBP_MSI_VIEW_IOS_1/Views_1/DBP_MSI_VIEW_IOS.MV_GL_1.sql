CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_GL_1 as
   -- LOOKUP Vertriebsline (Vertriebsschiene)
   -- 2011KW28 Review + Filter
   -- 20121127 Umstellung auf GL_Vertrieb, Anreicherung

   SELECT
   v01.mandant_id, v01.vs_id, v02.gl_vertrieb_id, v03.ma_anrede, v03.ma_name, v03.ma_vorname
   -- not used
   FROM
   dbp_view.v_vs_1 v01

   JOIN (
   SELECT DISTINCT
   w.mandant_id, w.vs_id, MAX(wd.gl_vertrieb_id) OVER (PARTITION BY w.mandant_id, w.vs_id) AS gl_vertrieb_id
   FROM dbp_view.v_wup_1 w
   LEFT JOIN dbp_msi_v_view.v_wup_denorm_1 wd
   ON w.mandant_id = wd.mandant_id
   AND w.wup_id=wd.wup_id

   WHERE w.nb_id IN (-2, -1, 0)
   AND dat_eroeffnung < '9999-12-31' -- NUR belannte eroeffnungen
   AND dat_bis = '9999-12-31' -- OHNE schliessungen
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.vs_id = v02.vs_id

   JOIN dbp_view.v_ma_spr_zu_1 v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.gl_vertrieb_id = v03.ma_id
   AND v03.spr_id=22;