CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_EGIN_WE_PALETTEN_NACH_ANLIEFERBEREICH_2(
	CLIENT_ID COMMENT 'Indicator of country_2',
	WH_ID COMMENT 'Warehouse number',
	WH_STAGING_AREA_CD COMMENT 'Warehouse area number',
	WH_DOCKING_GATE_NR COMMENT 'Tor',
	SUP_SID COMMENT 'Supplier_2 sid number',
	SPEDITION COMMENT 'Name of the carrier ',
	DAT_ENTRY_RCV COMMENT 'task completed date and time',
	EURO_PAL COMMENT 'Amount of Euro pallets',
	EURO_PAL_REJECTED COMMENT 'Amount of rejected euro pallets',
	DD_PAL COMMENT 'Amount of Düsseldorf pallets',
	DD_PAL_REJECTED COMMENT 'Amount of rejected Düsseldorf pallets',
	EURO_PAL_AUFGELAUFEN COMMENT 'cumulative euro pallets',
	DD_PAL_AUFGELAUFEN COMMENT 'cumulative Düsseldorf pallets',
	EURO_PAL_REJECTED_AUFGELAUFEN COMMENT 'cumulative rejected euro pallets',
	DD_PAL_REJECTED_AUFGELAUFEN COMMENT 'cumulative rejected Düsseldorf pallets',
	EURO_PAL_VJ COMMENT 'Amount of Euro pallets mapped to previous year',
	EURO_PAL_REJECTED_VJ COMMENT 'Amount of rejected euro pallets mapped to previous year',
	DD_PAL_VJ COMMENT 'Amount of Düsseldorf pallets mapped to previous year',
	DD_PAL_REJECTED_VJ COMMENT 'Amount of rejected Düsseldorf mapped to previous year',
	EURO_PAL_VJ_AUFGELAUFEN COMMENT 'cumulative euro pallets previous year',
	DD_PAL_VJ_AUFGELAUFEN COMMENT 'cumulative Düsseldorf pallets previous year',
	EURO_PAL_REJECTED_VJ_AUFGELAUFEN COMMENT 'cumulative rejected euro pallets previous year',
	DD_PAL_REJECTED_VJ_AUFGELAUFEN COMMENT 'cumulative rejected Düsseldorf pallets previous year'
) AS
SELECT 
	client_id
	,wh_id
	,wh_staging_area_cd
	,wh_docking_gate_nr
	,sup_sid
	,spedition
	,dat_entry_rcv
	,euro_pal
	,euro_pal_rejected
	,dd_pal
	,dd_pal_rejected
	,euro_pal_aufgelaufen
	,dd_pal_aufgelaufen
	,euro_pal_rejected_aufgelaufen
	,dd_pal_rejected_aufgelaufen
	,euro_pal_vj
	,euro_pal_rejected_vj
	,dd_pal_vj
	,dd_pal_rejected_vj
	,euro_pal_vj_aufgelaufen
	,dd_pal_vj_aufgelaufen
	,euro_pal_rejected_vj_aufgelaufen
	,dd_pal_rejected_vj_aufgelaufen
FROM p_lew_mart_lead.v_egin_we_paletten_nach_anlieferbereich_2
;