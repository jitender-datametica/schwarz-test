CREATE OR REPLACE VIEW p_lew_mart_lead_ac.v_elke_account_warehouse(
    CLIENT_ID COMMENT 'Identification of country',
	WH_ID COMMENT 'Identification of a warehouse',
	BUSYEAR COMMENT 'business year',
	CY_MONTH COMMENT 'calander month',
	CY_WEEK COMMENT 'calander week',
	DAT_DAYEND COMMENT 'Date where receipt was booked',
	CURRENCY_ISO_CD COMMENT 'currency used by the country',
	CURR_TOT_ID COMMENT 'Currency ID',
	LAGERUMSATZ_BRUTTO COMMENT 'Gutschrift minus Belastung',
	LAGERUMSATZ_BRUTTO_LJ_AUFGELAUFEN COMMENT 'cumulative warehouse revenue mapped to the current year',
	LAGERUMSATZ_BRUTTO_VJ COMMENT 'warehouse revenue from previous year',
	LAGERUMSATZ_BRUTTO_VJ_AUFGELAUFEN COMMENT 'cumulative warehouse revenue mapped to the previous year',
	RETOURENWERT_BRUTTO COMMENT 'The difference between Return and correction of return',
	RETOURENWERT_BRUTTO_LJ_AUFGELAUFEN COMMENT 'cumulative warehouse revenue mapped to the current year',
	RETOURENWERT_BRUTTO_VJ COMMENT 'warehouse revenue from previous year',
	RETOURENWERT_BRUTTO_VJ_AUFGELAUFEN COMMENT 'cumulative warehouse revenue mapped to the previous year',
	LAGERUMSATZ_NETTO_LJ COMMENT 'Gutschrift netto minus Belastung netto',
	LAGERUMSATZ_NETTO_LJ_AUFGELAUFEN COMMENT 'cumulative warehouse net revenue mapped to the current year',
	LAGERUMSATZ_NETTO_VJ COMMENT 'net warehouse revenue from previous year',
	LAGERUMSATZ_NETTO_VJ_AUFGELAUFEN COMMENT 'cumulative net warehouse revenue mapped to the previous year',
	RETOURENWERT_NETTO_LJ COMMENT 'the difference between return and correction of return in net value',
	RETOURENWERT_NETTO_LJ_AUFGELAUFEN COMMENT 'cumulative retour net value mapped to the current year',
	RETOURENWERT_NETTO_VJ COMMENT 'net retour value mapped to the previous year',
	RETOURENWERT_NETTO_VJ_AUFGELAUFEN COMMENT 'cumulative net retour value mapped to the previous year'
)
AS
SELECT 
	client_id
	,wh_id
	,busyear
	,cy_month
	,cy_week
	,dat_dayend
	,currency_iso_cd
	,curr_tot_id
	,lagerumsatz_brutto
	,lagerumsatz_brutto_lj_aufgelaufen
	,lagerumsatz_brutto_vj
	,lagerumsatz_brutto_vj_aufgelaufen
	,retourenwert_brutto
	,retourenwert_brutto_lj_aufgelaufen
	,retourenwert_brutto_vj
	,retourenwert_brutto_vj_aufgelaufen
	,lagerumsatz_netto_lj
	,lagerumsatz_netto_lj_aufgelaufen
	,lagerumsatz_netto_vj
	,lagerumsatz_netto_vj_aufgelaufen
	,retourenwert_netto_lj
	,retourenwert_netto_lj_aufgelaufen
	,retourenwert_netto_vj
	,retourenwert_netto_vj_aufgelaufen
FROM p_lew_mart_lead.v_elke_account_warehouse
;