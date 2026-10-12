CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ORACLE_FK_ADL_ACTIVE_ITEMS_1(
	COUNTRY_1,
	CY_WEEK,
	ITEM_NR,
	ITEM_PACKAGECAPACITY,
	WH,
	SUPPLIER_NR,
	ACTIVE
) 
COMMENT = 'Version: 1.4 - remove week filter'
AS

	/* Version: 1.4
	** Author:	Dominik Pfarr
	** Date: 	2024-10-01
	** Changes:	switch to item_Status_all; adjust timestamps again to 12 hr shift; 5 weeks-no weekfilter
	*/
	
SELECT dsi.country_1
	,c.cy_week
	,dsi.item_nr
	,dsi.item_packagecapacity
	,dsi.SUPPLIER_WH
	,dsi.supplier_nr
	,MAX(dsi.active) AS active
FROM CORE.T_ORACLE_V_DIM_SUPPLIER_ITEM_HIST_1 dsi
INNER JOIN FE_MSTR_AUTODISPO.V_DIM_CALENDAR_DATE_1 c
	/*for DWH_VALID_FROM_TMSP: changes before 12 noon [mod_date] should count for this day 
	for DWH_VALID_TO_TMSP:
	changes after 12 noon [mod_date] count for the day after 
	[adding 12 hrs and substracting 24 hrs to end the previous record 1 day before the new record is valid to avoid double coounting]
	*/
	ON c.cal_dt BETWEEN DATEADD(HOUR,12,dsi.DWH_VALID_FROM_TMSP)::DATE AND DATEADD(HOUR,-12,dsi.DWH_VALID_TO_TMSP)::DATE
INNER JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_ITEM_STATUS_ALL_1 dis
	ON dsi.country_1 = dis.country_1 
	AND dsi.SUPPLIER_WH = dis.dis_wh 
	AND dsi.item_nr = dis.dis_item_nr 
	AND dsi.item_packagecapacity = dis.dis_packagecapacity
WHERE cal_dt <= CURRENT_DATE -- past
 AND dis.dis_status BETWEEN 5 AND 8 -- only 1 kolli can exist in status_1 6-11 per item_1
GROUP BY dsi.country_1
	,c.cy_week
	,dsi.item_nr
	,dsi.item_packagecapacity
	,dsi.SUPPLIER_WH
	,dsi.supplier_nr;