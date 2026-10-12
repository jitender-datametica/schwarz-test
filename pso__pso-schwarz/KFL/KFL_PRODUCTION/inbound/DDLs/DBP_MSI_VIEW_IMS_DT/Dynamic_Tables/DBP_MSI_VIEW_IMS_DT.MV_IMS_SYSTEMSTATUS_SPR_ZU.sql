CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IMS_SYSTEMSTATUS_SPR_ZU
(
	SYSTEMSTATUS_ID,
	MANDANT_ID,
	SYSTEMSTATUS_BEZ_KURZ,
	SYSTEMSTATUS_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 20.08.2013 twie: Erstellung Sprachview Systemstatus
-- 20.08.2013 twie: gleiche ID kann in anderem Mandanten andere Bedeutung haben. Deshalb pro ID - Mandantkomination ein Eintrag in Landessprache. Attribut somit nicht mehrsprachfähig.

   SELECT
   v01.systemstatus_id,
   v01.mandant_id,
   v01.systemstatus_bez_kurz,
   v01.systemstatus_bez

  FROM dbp_view.v_ims_systemstatus_spr_zu v01
   JOIN dbp_view.v_mandant_spr_zu v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.spr_id = v02.spr_id
;