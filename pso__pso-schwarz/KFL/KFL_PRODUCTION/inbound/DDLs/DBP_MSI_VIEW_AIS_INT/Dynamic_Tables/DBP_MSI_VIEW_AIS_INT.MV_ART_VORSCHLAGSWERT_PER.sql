CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ART_VORSCHLAGSWERT_PER(
	ART_ID,
	DAT_VON,
	DAT_BIS,
	MANDANT_ID,
	SORTIMENTSLISTENART_ID,
	PALETTEN_FAKTOR_EINH_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
 AS
	SELECT
	art_id, 
	dat_von, 
	dat_bis, 
	mandant_id, 
	sortimentslistenart_id, 
	paletten_faktor_einh_id
	FROM dbp_data.art_vorschlagswert_per
	WHERE dat_bis = '9999-12-31'
	AND mandant_id = 1;