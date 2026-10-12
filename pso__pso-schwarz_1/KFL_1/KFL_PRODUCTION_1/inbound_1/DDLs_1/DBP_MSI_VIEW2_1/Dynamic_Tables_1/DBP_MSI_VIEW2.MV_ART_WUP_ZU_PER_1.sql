CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_WUP_ZU_PER_1
(
	ART_ID,
	BEZUGSWEG_ID,
	DAT_BIS,
	DAT_VON,
	LISTUNG_ID,
	MANDANT_ID,
	NB_ID,
	VK_BRUTTO,
	WUP_ID,
	KDIS_KZ,
	KDIS_AENDERUNG_DAT
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.art_id, 
v01.bezugsweg_id, 
v01.dat_bis, 
v01.dat_von, 
v01.listung_id, 
v01.mandant_id, 
v01.nb_id, 
v01.vk_brutto, 
v01.wup_id, 
v01.kdis, 
CURRENT_DATE

FROM dbp_view.v_art_wup_zu_per_1 v01
WHERE v01.mandant_id = 1
AND v01.dat_bis = '9999-12-31'
AND v01.nb_id <> 99;