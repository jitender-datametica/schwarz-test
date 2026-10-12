CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_VW_LIST_ZU_1
(
	ART_ID,
	MANDANT_ID,
	LIST_DURCHG_FG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
lsl.art_id,  
lsl.mandant_id,  
MAX(lsl.list_durchg_fg)

FROM dbp_view.v_sternchen_logik_1 AS lsl
WHERE lsl.mandant_id = 1
AND CURRENT_DATE BETWEEN lsl.dat_von AND lsl.dat_bis
GROUP BY 1,2;