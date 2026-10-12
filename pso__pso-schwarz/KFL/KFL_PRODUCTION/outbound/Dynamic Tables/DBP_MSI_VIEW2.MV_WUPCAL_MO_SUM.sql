CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_WUPCAL_MO_SUM
(
	WUP_ID,
	MANDANT_ID,
	NB_ID,
	KJMO,
	GJMO,
	ANZAHL_OEFF_TAGE,
	OFFEN,
	BONANZAHL,
	ANZAHL_LIEF_TAGE,
	BONANZAHL_GASTRO
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
wup_id,
mandant_id,
nb_id,
kjmo,
gjmo,
anzahl_oeff_tage,
offen,
bonanzahl,
anzahl_lief_tage,
bonanzahl_gastro

FROM dbp_view.v_wupcal_mo_sum 
WHERE mandant_id = 1
AND nb_id NOT IN (2,6,7);
