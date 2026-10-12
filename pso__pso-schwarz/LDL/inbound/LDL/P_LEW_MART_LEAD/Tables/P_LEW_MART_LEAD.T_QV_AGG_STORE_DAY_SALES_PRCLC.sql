/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_SALES_PRCLC
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-06-23 Prasanna Ranjan         20200309_2424_QuickView_remove_dum
#
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_SALES_PRCLC CLUSTER BY (client_id, dat_formdate)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Landeskennzeichen',
	CLIENT_DESC VARCHAR(35) COLLATE 'en-ci' COMMENT 'Bezeichnung des Landes',
	ACCOUNT_MANAGER_ID NUMBER(38,0) COMMENT 'Vertriebsleiter-Nr.',
	ACCOUNT_MANAGER_NAME VARCHAR(50) COLLATE 'en-ci' COMMENT 'Vertriebsleiter-Name',
	SALES_MANAGER_ID NUMBER(38,0) COMMENT 'Bezirksleiter-Nr.',
	SALES_MANAGER_NAME VARCHAR(50) COLLATE 'en-ci' COMMENT 'Bezirksleiter-Name',
	MOVE_TO_STORE_ID NUMBER(38,0) NOT NULL COMMENT 'Filial-Nr. nach letztem Filialumzug',
	MOVE_STORE_DESC VARCHAR(50) COLLATE 'en-ci' COMMENT 'Filialname nach letztem Filialumzug',
	WH_ID NUMBER(38,0) COMMENT 'Gesellschaftsnummer',
	WH_DESC VARCHAR(50) COLLATE 'en-ci' COMMENT 'Gesellschaftsbezeichnung',
	WH_ID_EXP NUMBER(38,0) COMMENT 'Gesellschafts-Nr.-exp',
	ASPECT_ID NUMBER(38,0) NOT NULL COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	ASPECT_DESC VARCHAR(4) COLLATE 'en-ci' COMMENT 'Gesellschaftsform Bezeichnung',
	CURRENCY_ISO_CD VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Iso-Code Waehrung',
	CURR_TOT_ID NUMBER(38,0) COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id',
	DAT_FORMDATE DATE NOT NULL COMMENT '\u00C4nderungsdatum',
	MIS_STORE_ACTIVE_FG NUMBER(38,0) COMMENT 'MIS Flag zur Kennzeichnung aktiver Filialen',
	VAL_RETAIL_NET_ASIS NUMBER(19,5) COMMENT 'Umsatz (net value)',
	VAL_RETAIL_NET_ASIS_PY NUMBER(19,5) COMMENT 'Umsatz (net value), Vorjahr',
	CNT_CUSTOMER_ASIS NUMBER(19,5) COMMENT 'Anzahl der aktuellen Kunden',
	CNT_CUSTOMER_ASIS_PY NUMBER(19,5) COMMENT 'Anzahl der aktuellen Kunden, Vorjahr',
	VAL_RETAIL_GROSS_ASIS NUMBER(19,5) COMMENT 'Umsatz (gross value)',
	VAL_RETAIL_GROSS_ASIS_PY NUMBER(19,5) COMMENT 'Umsatz (gross value), Vorjahr',
	CNT_CUSTOMER_ADJ_ASIS NUMBER(19,5) COMMENT 'Anzahl der aktuellen Kunden bereinigt',
	CNT_CUSTOMER_ADJ_ASIS_PY NUMBER(19,5) COMMENT 'Anzahl der aktuellen Kunden bereinigt, Vorjahr',
	CNT_CUSTOMER_ADJ_ASIS_PPY NUMBER(19,5) COMMENT 'Anzahl der aktuellen Kunden bereinigt, Vorvorjahr',
	VAL_RETAIL_NET_ADJ_ASIS NUMBER(19,5) COMMENT 'Umsatz bereinigt (net value)',
	VAL_RETAIL_NET_ADJ_ASIS_PY NUMBER(19,5) COMMENT 'Umsatz bereinigt (net value), Vorjahr',
	VAL_RETAIL_NET_ADJ_ASIS_PPY NUMBER(19,5) COMMENT 'Umsatz bereinigt (net value), Vorvorjahr',
	VAL_RETAIL_GROSS_ADJ_ASIS NUMBER(19,5) COMMENT 'Umsatz bereinigt (gross value)',
	VAL_RETAIL_GROSS_ADJ_ASIS_PY NUMBER(19,5) COMMENT 'Umsatz bereinigt (gross value), Vorjahr',
	VAL_RETAIL_GROSS_ADJ_ASIS_PPY NUMBER(19,5) COMMENT 'Umsatz bereinigt (gross value), Vorvorjahr',
	VAL_RTL_GRO_EXTRAPOL_ASIS NUMBER(19,5) COMMENT 'Umsatz vorausgerechnet (gross value)',
	VAL_RTL_NET_EXTRAPOL_ASIS NUMBER(19,5) COMMENT 'Umsatz vorausgerechnet (net value)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Record created timestamp',
	DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Record updated timestamp',
	UNIQUE (CLIENT_ID, MOVE_TO_STORE_ID, ASPECT_ID, CURRENCY_ISO_CD, DAT_FORMDATE)
)COMMENT='Table'
;
