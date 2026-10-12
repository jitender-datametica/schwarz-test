CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_AUSNAHME_MBR
(
	ART_ID,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	DAT_PLAN,
	PRUEF_ID,
	PSEUDOANZEIGE,
	Z_ARBEITSGEBIET_ID,
	GP_ID,
	AUSNAHME_MUTTER_ID,
	AUSNAHME_MENGE_BME,
	AUSNAHME_MENGE_KOLLI
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.art_id, 
COALESCE (v02.wup_id, v01.wup_id) AS wup_id, 
COALESCE (v02.nb_id,v01.nb_id) AS nb_id, 
v01.mandant_id, 
v01.dat_plan, 
v01.pruef_id, 
CASE WHEN v01.pruef_id IN (210, 220) THEN '210 / 220' END AS Pseudoanzeige, 
CASE WHEN v01.z_arbeitsgebiet_id = 0 THEN 'Z' WHEN v01.z_arbeitsgebiet_id = 1 THEN 'S' ELSE ' ' END AS z_arbeitsgebiet_id, 
COALESCE (v02.gp_id, v01.gp_id) AS gp_id, 
v01.ausnahme_mutter_id, 
v01.ausnahme_menge_bme, 
v01.ausnahme_menge_kolli

FROM dbp_view.v_ausnahme v01
INNER  JOIN
(
SELECT
ausnahme_id, mandant_id, wup_id, nb_id, dat_plan, gp_id
FROM dbp_view.v_ausnahme
WHERE pruef_id = 220
) v02
ON v01.mandant_id = v02.mandant_id
AND v01.ausnahme_mutter_id = v02.ausnahme_id
AND v01.dat_plan = v02.dat_plan

WHERE v01.mandant_id = 1
AND v01.pruef_id  IN (210)
AND v01.z_arbeitsgebiet_id = 0;
