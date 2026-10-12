CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_BAUSTEIN_ART_WUP_ZU_PER_1
(
	BAUSTEIN_ID,
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	DAT_BIS_ART,
	DAT_VON_ART,
	DAT_BIS_WUP,
	DAT_VON_WUP
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.baustein_id,  
v01.mandant_id,  
v01.art_id,  
v02.wup_id,  
v02.nb_id,  
v01.dat_bis,  
v01.dat_von,  
v02.dat_bis,  
v02.dat_von

FROM dbp_msi_v_view.v_baustein_art_zu_per_msi_1 v01

JOIN dbp_view.v_baustein_wup_zu_per_1 v02
ON v01.baustein_id = v02.baustein_id
AND v01.mandant_id = v02.mandant_id
WHERE v01.mandant_id = 1;