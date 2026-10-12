/*
====================================================================================================
Division		   |	Lidl
Solution		   |	Operational Logistics (LOGOP)
DB schema		   |	fe_mstr_logop
DB table/view	   |	v_wamas_dashboard_leistung_1
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAMAS_DASHBOARD_LEISTUNG_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	LAGERZONE_NR COMMENT 'Lagerzone Nummer',
	KOMMISSIONIERER COMMENT 'picker',
	KSNR COMMENT 'picking list number. PK/FK',
	KS_DATE COMMENT 'picking date',
	ZEIT_1 COMMENT 'picking date and time',
	HR_SS COMMENT 'hour in second',
	LIEFERDATUM COMMENT 'delivery date',
	ANZAHL_FERTIG_KOLLI COMMENT 'Number of picked collis based on LEISTP',
	KOMMISSIONIERZEIT_IN_HOUR COMMENT 'Time on commission in hour format',
	ANZPICKTE COMMENT 'Number of picked TE',
	ANZPICKHANDHE COMMENT 'Number of Hand picked HE',
	SUMANZPAUSE COMMENT 'the number of breaks',
	PAUSENZEIT_IN_MIN COMMENT 'break time in min',
	DWH_UPDATED COMMENT 'Last update of table'
) AS
SELECT 
	lp.client_id
   ,lp.wh_id
   ,lp.lazid_laznr AS lagerzone_nr
   ,lp.kommissionierer
   ,lp.ksnr
   ,lp.ks_date
   ,lp.zeit_1
   ,CONCAT(SUBSTRING(TIME(zeit_1),1,2),':00:00') AS hr_ss
   ,vplk.lieferdatum
   ,lp.anzahl_fertig_kolli
   ,lp.kommissionierzeit_in_hour
   ,lp.anzpickte
   ,lp.anzpickhandhe
   ,lp.sumanzpause
   ,lp.sumpausezeit/60 AS pausenzeit_in_min
   ,lp.dwh_updated
FROM "DATA".T_WAMAS_LEISTP_1 lp
LEFT JOIN "DATA".T_WAMAS_VPLK_1 vplk
ON lp.client_id = vplk.client_id
AND lp.wh_id = vplk.wh_id
AND lp.ksnr = vplk.ksnr
AND lp.lazid_laznr = vplk.laznr
AND CURRENT_DATE BETWEEN vplk.dwh_valid_from AND vplk.dwh_valid_to
AND vplk.deleted_fg = FALSE 
WHERE lp.leistart = 'MIN15'
AND CURRENT_DATE BETWEEN lp.dwh_valid_from AND lp.dwh_valid_to
AND lp.deleted_fg = FALSE
AND lp.sumistzeit !=0;