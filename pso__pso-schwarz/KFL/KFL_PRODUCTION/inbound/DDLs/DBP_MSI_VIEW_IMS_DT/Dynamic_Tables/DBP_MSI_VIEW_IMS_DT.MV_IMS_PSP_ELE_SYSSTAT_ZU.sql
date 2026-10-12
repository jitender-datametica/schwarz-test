CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IMS_PSP_ELE_SYSSTAT_ZU
(
	MANDANT_ID,
	PSP_ID,
	SYSTEMSTATUS_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 20.08.2013 twie: Erstellung Zuordnung PSP-Element - Systemstatus

   SELECT
   v01.mandant_id,
   v01.psp_id,
   COALESCE(v02.systemstatus_id, '-1') AS systemstatus_id

   FROM dbp_view.v_in_psp_element v01
   LEFT OUTER JOIN dbp_view.v_ims_psp_ele_sysstat_zu v02
   ON v01.psp_id = v02.psp_id
   AND v01.mandant_id = v02.mandant_id
   --Neue Projekte nur statistisch
   WHERE v01.statistisch_fg  = 1
;