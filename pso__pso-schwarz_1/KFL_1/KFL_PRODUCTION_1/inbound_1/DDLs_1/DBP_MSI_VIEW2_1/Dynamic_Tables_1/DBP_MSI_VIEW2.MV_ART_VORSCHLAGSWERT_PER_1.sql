CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_VORSCHLAGSWERT_PER_1
(
	ART_ID,
	DAT_VON,
	DAT_BIS,
	MANDANT_ID,
	SORTIMENTSLISTENART_ID,
	PALETTEN_FAKTOR_EINH_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
art_id, 
dat_von, 
dat_bis, 
mandant_id, 
sortimentslistenart_id, 
paletten_faktor_einh_id

FROM dbp_view.v_art_vorschlagswert_per_1
WHERE dat_bis = '9999-12-31'
AND mandant_id = 1;
