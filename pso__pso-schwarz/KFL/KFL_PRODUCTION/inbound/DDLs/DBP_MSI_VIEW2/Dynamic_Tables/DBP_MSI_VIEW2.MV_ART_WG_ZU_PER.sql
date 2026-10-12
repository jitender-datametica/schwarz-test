CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_WG_ZU_PER
(
	ART_ID,
	MANDANT_ID,
	ARTHIERTYP_ID,
	WUG_ID,
	WG_ID,
	DAT_VON,
	DAT_BIS
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT 
art_id, 
mandant_id, 
arthiertyp_id, 
wug_id, 
wg_id, 
dat_von, 
dat_bis 
FROM dbp_view.v_art_wg_zu_per 
WHERE arthiertyp_id = 2 
AND mandant_id = 1
AND dat_bis = '9999-12-31';