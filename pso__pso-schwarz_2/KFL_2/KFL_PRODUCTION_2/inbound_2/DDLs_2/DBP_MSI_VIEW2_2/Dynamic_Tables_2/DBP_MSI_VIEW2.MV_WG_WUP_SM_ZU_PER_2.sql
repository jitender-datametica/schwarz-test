CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_WG_WUP_SM_ZU_PER_2
(
	MANDANT_ID,
	WUP_ID,
	WG_ID,
	NB_ID,
	DAT_VON,
	ARTHIERTYP_ID,
	DAT_BIS,
	SM_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
mandant_id, 
wup_id, 
wg_id, 
nb_id, 
dat_von, 
arthiertyp_id, 
dat_bis, 
sm_id

FROM dbp_view.v_sm_wup_wg_zu_per_2
WHERE mandant_id = 1 
AND arthiertyp_id = 2
AND dat_bis='9999-12-31'
AND nb_id <> 99;
