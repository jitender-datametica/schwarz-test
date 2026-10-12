CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MIETUEBERSICHT_FILTER(
	MANDANT_ID,
	MV_INTRENO,
	BRANCHE_ID,
	KONZESSIONAER_ID,
	MO_STATUS_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT DISTINCT
   mandant_id, mv_intreno, branche_id, konzessionaer_id, mo_status_id
   FROM dbp_msi_view_immo.mv_f_mietuebersicht_akt
   WHERE mo_status_id=4;