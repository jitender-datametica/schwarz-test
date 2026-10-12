/*
====================================================================================================
Division		    |	Lidl
Solution		    |	Operational Logistics (LOGOP)
DB schema			|	fe_mstr_logop.
DB table/view		|	v_wamas_dashboard_stapleranfragen_1
====================================================================================================
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAMAS_DASHBOARD_STAPLERANFRAGEN_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	LAGERZONE_NR COMMENT 'Lagerzone Nummer',
	TANR COMMENT 'Transport number',
	KSNR COMMENT 'Commission number. PK/FK',
	STATUS_1 COMMENT 'status_1 of the transport',
	START_DATE COMMENT 'date when a transport is started',
	END_DATE COMMENT 'date when a transport is over',
	LIEFERDATUM COMMENT 'delivery date',
	ARTIKELNR COMMENT 'article number',
	DWH_UPDATED COMMENT 'Last update of table'
) COMMENT='This is a View for WAMAS Dashboard to calculate the number of the driver order'
 AS
SELECT 
	 TPA.client_id
	,TPA.wh_id
	,TPA.lagerzone_nr
	,TPA.tanr
	,TPA.ksnr
	,TPA.status_1
	,TPA.start_date
	,TPA.end_date
	,VPLK.lieferdatum
	,TPAP.artikelnr
	,TPA.dwh_updated
FROM "DATA".T_WAMAS_TPA_1 TPA
LEFT JOIN "DATA".T_WAMAS_TPAP_1 TPAP
ON TPA.client_id = TPAP.client_id
AND TPA.wh_id = TPAP.wh_id
AND TPA.tanr = TPAP.tanr
AND CURRENT_DATE BETWEEN TPAP.dwh_valid_from AND TPAP.dwh_valid_to
AND TPAP.deleted_fg = FALSE
LEFT JOIN "DATA".T_WAMAS_VPLK_1 VPLK
ON TPA.client_id = VPLK.client_id
AND TPA.wh_id = VPLK.wh_id
AND TPA.ksnr = VPLK.ksnr
AND TPA.lagerzone_nr = VPLK.laznr
AND CURRENT_DATE BETWEEN VPLK.dwh_valid_from AND VPLK.dwh_valid_to
AND VPLK.deleted_fg = FALSE 
WHERE TPAP.artikelnr NOT IN ('00000000000000000000')
AND TPA.status_1 IN ('SENDEN')
AND CURRENT_DATE BETWEEN TPA.dwh_valid_from AND TPA.dwh_valid_to
AND TPA.deleted_fg = FALSE;