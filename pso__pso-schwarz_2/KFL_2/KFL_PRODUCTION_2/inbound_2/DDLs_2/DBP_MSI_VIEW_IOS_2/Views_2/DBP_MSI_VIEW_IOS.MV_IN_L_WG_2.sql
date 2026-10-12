CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_IN_L_WG_2
-- 2015-10-13 kkai0912 : initial Projekt 0533
--20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung: Auslagegerung von bez und bez_lang in spr_zu

(
mandant_id
,in_wg_id
,in_wg_struktur_id
/*,in_wg_bez
,in_wg_bez_lang*/


)

AS

   SELECT
   v01.mandant_id, v01.in_wg_id, v01.in_wg_struktur_id
   /*,v02.in_wg_bez
   ,v02.in_wg_bez_lang*/

   FROM
   dbp_view.v_in_l_wg_2 v01
   /*JOIN dbp_view.v_in_wg_spr_zu_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.in_wg_id = v02.in_wg_id
   AND v02.spr_id = 22*/
   WHERE
   SUBSTR( v01.in_wg_id, 1, 1) = 'W';