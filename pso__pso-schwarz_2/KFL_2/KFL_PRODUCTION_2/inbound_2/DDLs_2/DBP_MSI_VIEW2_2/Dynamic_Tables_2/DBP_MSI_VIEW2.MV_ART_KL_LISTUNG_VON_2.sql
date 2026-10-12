CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_KL_LISTUNG_VON_2
(
	ART_ID,
	MANDANT_ID,
	KL_ID,
	DAT_VON,
	DAT_ERST_LISTUNG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
art_id,  
mandant_id,  
1,  
MIN(dat_von) AS dat_von,  
MIN(dat_erst_listung) AS dat_erst_listung

FROM dbp_view.v_art_vw_listung_von_2
WHERE mandant_id = 1
GROUP BY 1,2,3;
