CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_RPM_FIN_PLANTYP
-- kkaiser: 20150921 Projekt 533, neu als Lookup
--20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung: Auslagegerung von bez in spr_zu
(
rpm_plantyp_id
/*,rpm_plantyp_bez*/

)

AS
   SELECT
   v01.rpm_plantyp_id
   /*,v02.rpm_plantyp_bez*/

   FROM
   dbp_view.v_l_rpm_plantyp v01

   /*LEFT OUTER JOIN  dbp_view.v_rpm_plantyp_spr_zu v02
   ON    v01.rpm_plantyp_id = v02.rpm_plantyp_id
   AND v02.spr_id = 22*/
   ;