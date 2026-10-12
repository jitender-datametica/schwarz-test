CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_RPM_FIN_GRUPPE
-- kkaiser: 20150921 Projekt 533, neu als Lookup
--20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung: Auslagegerung von bez in spr_zu
(
--fin_gruppe_hierarchie_id
--,fin_kat_hierarchie_id
--,
fin_gruppe_id
,fin_kategorie_id
,fin_gruppe_version_id
,fin_gruppe_version_dat
/*,fin_gruppe_bez*/

)

AS
   SELECT
   --v02.fin_gruppe_hierarchie_id
   --,v02.fin_kat_hierarchie_id
   --,
   v01.fin_gruppe_id, v01.fin_kategorie_id, v02.fin_gruppe_version_id, v02.fin_gruppe_version_dat
   /*,v03.fin_gruppe_bez*/

   FROM
   dbp_view.v_l_rpm_fin_gruppe v01
   LEFT OUTER JOIN dbp_view.v_rpm_fin_gruppe v02
   ON v01.fin_gruppe_id = v02.fin_gruppe_id
   AND v01.fin_kategorie_id = v02.fin_kategorie_id

   /*LEFT OUTER JOIN  dbp_view.v_rpm_fin_gruppe_spr_zu v03
   ON    v01.fin_gruppe_id = v03.fin_gruppe_id
   AND v01.fin_kategorie_id = v03.fin_kategorie_id
   AND v03.spr_id = 22*/

   GROUP BY 1,2,3,4/*,5*/
   ;