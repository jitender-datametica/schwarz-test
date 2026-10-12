CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_EWMPS_DASHBOARD_LEISTUNG_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	LAGERZONE_NR COMMENT 'Lagerzone Nummer',
	KOMMISSIONIERER COMMENT 'picker',
	KSNR COMMENT 'picking list number. PK/FK',
	KS_DATE COMMENT 'picking date',
	HR_SS COMMENT 'hour in second',
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
   ,lp.leistuser
   ,lp.ksnr
   ,DATE(lp.zeit_1)
   ,CONCAT(SUBSTRING(TIME(lp.zeit_1),1,2),':00:00') AS hr_ss
   ,SUM(lp.sumistzeit/3600) AS kommissionierzeit_in_hour
   ,SUM(lp.anzpickte)
   ,SUM(lp.anzpickhandhe)
   ,SUM(lp.sumanzpause)
   ,SUM(lp.sumpausezeit/60 )AS pausenzeit_in_min
   ,lp.dwh_updated
FROM "DATA".T_EWMPS_LEISTP_1 lp
WHERE lp.leistart = 'STD'
AND CURRENT_DATE BETWEEN lp.dwh_valid_from AND lp.dwh_valid_to
AND DATE(lp.zeit_1) BETWEEN CURRENT_DATE-7 AND CURRENT_DATE
AND lp.deleted_fg = FALSE
AND lp.sumistzeit !=0
GROUP BY 
    lp.client_id
   ,lp.wh_id
   ,lp.lazid_laznr 
   ,lp.leistuser
   ,lp.ksnr
   ,DATE(lp.zeit_1)
   ,CONCAT(SUBSTRING(TIME(lp.zeit_1),1,2),':00:00')
   ,lp.dwh_updated
;