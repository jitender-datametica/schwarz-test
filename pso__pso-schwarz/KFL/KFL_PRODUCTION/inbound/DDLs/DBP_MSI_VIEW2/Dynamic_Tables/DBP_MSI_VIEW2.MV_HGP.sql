CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_HGP
(
	HGP_ID,
	HGP_NAME,
	MANDANT_ID,
	ZEK_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT DISTINCT
gp_id, 
gp_name, 
mandant_id, 
zek_id

FROM dbp_view.v_gp
WHERE gp_id IN (
   SELECT hgp_id
   FROM dbp_view.v_gp
   WHERE mandant_id = 1
   )
AND mandant_id = 1;