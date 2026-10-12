CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_LIST_WUP_ZU_PER
(
	ART_ID,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
art_id,  
wup_id,  
nb_id,  
mandant_id,  
MIN(dat_von),  
MAX(dat_bis)

FROM dbp_view.v_art_list_wup_zu_per
WHERE mandant_id = 1
AND nb_id = 0
AND CURRENT_DATE BETWEEN dat_von AND dat_bis
GROUP BY 1,2,3,4
;