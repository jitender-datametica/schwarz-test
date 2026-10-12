CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MO_STATUS(
	MANDANT_ID,
	MO_STATUS_ID,
	MO_STATUS_BEZ,
	SPR_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v0.mandant_id, v0.mo_status_id, v1.mo_status_bez, v1.spr_id

   FROM dbp_view.v_immo_l_mo_status v0

   JOIN dbp_view.v_immo_mo_status_spr_zu v1
   ON v0.mandant_id = v1.mandant_id
   AND v0.mo_status_id = v1.mo_status_id
   
   WHERE v1.spr_id=22
   

   UNION ALL

   SELECT
   mandant_id, -1 AS mo_status_id, '' AS mo_status_bez, 22 AS spr_id

   FROM dbp_view.v_mandant;