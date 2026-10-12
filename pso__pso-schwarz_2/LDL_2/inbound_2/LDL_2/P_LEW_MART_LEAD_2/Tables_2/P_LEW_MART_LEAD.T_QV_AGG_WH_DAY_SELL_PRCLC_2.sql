/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_SELL_PRCLC_2
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-05-04 Rodrigo Cione           20200309_2424_QuickView_remove_dum
#
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_SELL_PRCLC_2 CLUSTER BY (client_id, dat_formdate)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Landeskennzeichen',
	CLIENT_DESC VARCHAR(35) COLLATE 'en-ci' COMMENT 'Bezeichnung des Landes',
	COUNTRY_GROUP_ID NUMBER(38,0) COMMENT 'Landesgruppe Kennzeichen',
	COUNTRY_GROUP_DESC VARCHAR(60) COLLATE 'en-ci' COMMENT 'Landesgruppe Bezeichnung',
	GL_REGION_ID NUMBER(38,0) COMMENT 'Geschaeftsleitungsregion ID',
	GL_REGION_DESC VARCHAR(60) COLLATE 'en-ci' COMMENT 'Beschreibung Geschaeftsleitungsregion',
	WH_ID NUMBER(38,0) NOT NULL COMMENT 'Gesellschaftsnummer',
	WH_DESC VARCHAR(50) COLLATE 'en-ci' COMMENT 'Gesellschaftsbezeichnung',
	ASPECT_ID NUMBER(38,0) NOT NULL COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	ASPECT_DESC VARCHAR(4) COLLATE 'en-ci' COMMENT 'Gesellschaftsform Bezeichnung',
	CURRENCY_ISO_CD VARCHAR(3) NOT NULL COMMENT 'Iso-Code Waehrung',
	CURR_TOT_ID NUMBER(38,0) COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id',
	DAT_FORMDATE DATE NOT NULL COMMENT 'Aenderungsdatum',
	MIS_STORE_ACTIVE_FG NUMBER(38,0) COMMENT 'MIS Flag zur Kennzeichnung aktiver Filialen',
	VAL_ADJ_GROSS_SFO_STORE NUMBER(19,5) COMMENT 'Abschriften_2 Filiale (gross value)',
	VAL_ADJ_GROSS_SFO_STORE_PY NUMBER(19,5) COMMENT 'Abschriften_2 Filiale (gross value), Vorjahr',
	VAL_ADJ_NET_SFO_STORE NUMBER(19,5) COMMENT 'Abschriften_2 Filiale (net value)',
	VAL_ADJ_NET_SFO_STORE_PY NUMBER(19,5) COMMENT 'Abschriften_2 Filiale (net value), Vorjahr',
	VAL_RTL_GRO_WT_HRS_NET NUMBER(19,5) COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (gross value)',
	VAL_RTL_GRO_WT_HRS_NET_PY NUMBER(19,5) COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (gross value), Vorjahr',
	VAL_RTL_NET_WT_HRS_NET NUMBER(19,5) COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (net value)',
	VAL_RTL_NET_WT_HRS_NET_PY NUMBER(19,5) COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (net value), Vorjahr',
	VAL_RETAIL_GROSS_ASIS NUMBER(19,5) COMMENT 'Umsatz (gross value)',
	VAL_RETAIL_GROSS_ASIS_PY NUMBER(19,5) COMMENT 'Umsatz (gross value), Vorjahr',
	VAL_RETAIL_NET_ASIS NUMBER(19,5) COMMENT 'Umsatz (net value)',
	VAL_RETAIL_NET_ASIS_PY NUMBER(19,5) COMMENT 'Umsatz (net value), Vorjahr',
	WT_HRS_NET NUMBER(19,5) COMMENT 'Arbeitsstunden effektiv',
	WT_HRS_NET_PY NUMBER(19,5) COMMENT 'Arbeitsstunden effektiv, Vorjahr',
	MT_HRS_NET NUMBER(19,5) COMMENT 'Schulungsstunden',
	MT_HRS_NET_PY NUMBER(19,5) COMMENT 'Schulungsstunden, Vorjahr',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load Identification',
	DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Insert record timestamp',
	DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Update record timestamp',
	UNIQUE (CLIENT_ID, WH_ID, ASPECT_ID, CURRENCY_ISO_CD, DAT_FORMDATE)
)COMMENT='Table contains the base data for the QuickView cube Ware Verkaufen. Data is provided by wh and day.'
;