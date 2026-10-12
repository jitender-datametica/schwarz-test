CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_AKTION_2
   (
	AKTION_ID,
	MANDANT_ID,
	BEWART_ID,
	AKTIONSART_ID,
	WERBE_KAT_ID,
	DAT_VON,
	DAT_BIS,
	WW_KJWO
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.aktion_id, 
v01.mandant_id, 
v01.bewart_id, 
v01.aktionsart_id, 
v01.werbe_kat_id, 
v01.dat_von, 
v01.dat_bis, 
v01.kjwo_von AS ww_kjwo

FROM dbp_view.v_aktion_2 v01
INNER JOIN dbp_view.v_woche_kj_kl_2 v02
ON  v01.kjwo_von = v02.kjwo
WHERE mandant_id = 1
AND v02.akt_kj BETWEEN -3 AND 0;