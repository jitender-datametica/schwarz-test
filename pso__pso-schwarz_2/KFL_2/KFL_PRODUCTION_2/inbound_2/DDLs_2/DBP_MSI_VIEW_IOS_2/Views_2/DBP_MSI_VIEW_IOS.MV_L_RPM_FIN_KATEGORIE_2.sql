CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_RPM_FIN_KATEGORIE_2
-- kkaiser: 20150921 Projekt 533, neu als Lookup
--20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung: Auslagegerung von bez in spr_zu
(
fin_kategorie_id
/*,spr_id
,fin_kategorie_bez*/

)

AS
   SELECT
   fin_kategorie_id
   /*,spr_id
   ,fin_kategorie_bez*/

   FROM
   dbp_view.v_rpm_fin_kategorie_spr_zu_2 v03

   /*WHERE v03.spr_id = 22*/
   ;