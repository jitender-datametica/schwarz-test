CREATE TABLE DATA.t_lead_elke_kpi_daily_lc_1 (
CLIENT_ID 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
COUNTRY_ISO_CODE 		VARCHAR(3)		NOT NULL 	COMMENT 'Country_1 code',
WH_ID 					NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse number',
DATUM 					DATE			NULL 	 	COMMENT 'calendar_1 date',
WE_PALETTEN 			NUMBER(38,0)	NULL 	 	COMMENT 'the amount of incoming pallets - sum of euro pallets + düsseldorf pallets/pallet factor',
AUSGELIEFERTE_KOLLI 	NUMBER(32,0)	NULL 	 	COMMENT 'delivery cases',
LAGERUMSATZ_BRUTTO 		NUMBER(38,2)	NULL 	 	COMMENT 'warehouse revenue gross value',
RETOURENWERT_BRUTTO 	NUMBER(38,2)	NULL 	 	COMMENT 'gross retour value',
LAGERUMSATZ_NETTO 		NUMBER(38,2)	NULL 	 	COMMENT 'net value of warehouse revenue',
RETOURENWERT_NETTO 		NUMBER(38,2)	NULL 	 	COMMENT 'net retour value',
KOMMISSIONIERTE_KOLLI 	NUMBER(38,5)	NULL 	 	COMMENT 'picked cases',
KOMMISSIONIERZEIT_SEC 	NUMBER(38,4)	NULL 	 	COMMENT 'picking time in sec',
CURRENCY_ISO_CODE 		VARCHAR(3)		NULL 	 	COMMENT 'currency iso code'
) COMMENT = 'LEAD - A copy of the data from LDL_PRODUCTION.P_LEW_MART_LEAD.V_LEAD_ELKE_KPI_DAILY_LC_1';