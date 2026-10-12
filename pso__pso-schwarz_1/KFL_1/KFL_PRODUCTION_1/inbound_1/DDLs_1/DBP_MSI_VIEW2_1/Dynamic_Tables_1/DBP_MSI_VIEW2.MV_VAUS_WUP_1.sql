CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_VAUS_WUP_1
(
	MANDANT_ID,
	NB_ID,
	LAND_ID,
	WUP_ID,
	BUCHUNGSKREIS_ID,
	GLN_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
   SELECT
   v01.mandant_id, 
   v01.nb_id, 
   v01.land_id, 
   v01.wup_id, 
   v01.buchungskreis_id, 
   v02.gln_id

   FROM dbp_view.v_wup_1  v01
   LEFT JOIN dbp_view.v_vaus_wup_1  v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   WHERE v01.mandant_id = 1
   
   AND NOT v01.wup_id BETWEEN 1 AND 999
   AND v01.nb_id <> 99;
