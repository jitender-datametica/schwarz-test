create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BESCH_FAKTURA_WERBECLUSTER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	KJWO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahreswoche, Format JJJJWW',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	ART_ID NUMBER(38,0) NOT NULL COMMENT '\""Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig);\n            \n            Output: 7stellige L&S-ID + Counter = 9stellige ArtikelID. WWNNNNPCC (Warengruppe, Nummer, Prüfziffer, Counter)\n            \n            Regel: Neuer Artikel_2 -> Counter +1\""\n            ',
	FAKTURA_MENGE_AF_1FW NUMBER(18,3) NOT NULL COMMENT 'Fakturamenge BME AF der ersten Folgewerbewoche',
	FAKTURA_MENGE_AF_2FW NUMBER(18,3) NOT NULL COMMENT 'Fakturamenge BME AF der zweiten Folgewerbewoche',
	FAKTURA_MENGE_AF_3FW NUMBER(18,3) NOT NULL COMMENT 'Fakturamenge BME AF der dritten Folgewerbewoche',
	FAKTURA_MENGE_AF_6VW NUMBER(18,3) NOT NULL COMMENT 'Fakturamenge BME AF der sechsten Vorwerbewoche',
	FAKTURA_MENGE_SA_1VW NUMBER(18,3) NOT NULL COMMENT 'Fakturamenge BME SA der ersten Vorwerbewoche',
	FAKTURA_MENGE_SA_WW NUMBER(18,3) NOT NULL COMMENT 'Fakturamenge BME SA der aktuellen Werbewoche',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BESCH_FAKTURA_WERBECLUSTER primary key (MANDANT_ID, WUP_ID, NB_ID, KJWO, WG_ID, ART_ID)
)COMMENT='AIS - Aggregat für Fakturmengen auf Wochenebene - MULTISET'
;
