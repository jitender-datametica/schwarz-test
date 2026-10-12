CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_WG_WUP_PM_ZU_PER_1
(
	WUP_ID,
	NB_ID,
	ARTHIERTYP_ID,
	WG_ID,
	PM_ID,
	DAT_VON,
	DAT_BIS,
	MANDANT_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
wup_id, 
nb_id, 
arthiertyp_id, 
wg_id, 
pm_id, 
dat_von, 
dat_bis, 
mandant_id
FROM dbp_view.v_pm_wup_wg_zu_per_1
WHERE mandant_id=1
AND arthiertyp_id=2
AND dat_bis > CURRENT_DATE
AND nb_id <> 99;
