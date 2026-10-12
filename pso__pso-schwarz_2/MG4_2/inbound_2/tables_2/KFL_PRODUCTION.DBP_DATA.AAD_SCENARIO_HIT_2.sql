create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_SCENARIO_HIT_2 (
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Scenario',
	BON_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert.',
	BON_DAT DATE NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
	BON_NR NUMBER(38,0) COMMENT 'Die Bonnummer des Bons (ist eine_2 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_2 und Kasse unique)',
	BON_BOOKING TIMESTAMP_NTZ(9) COMMENT 'Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war.',
	KASSE_NR NUMBER(38,0) COMMENT 'Nummer der Kasse.',
	HASHED_CASHIER_ID VARCHAR(255) COMMENT 'Encrypted (hashed) Cashier ID',
	FRAUD_VALUE_GROSS_LOCAL_VAL NUMBER(18,4) COMMENT 'Amount of the fraud',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Insert',
	DWH_UPDATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Update',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_SCENARIO_HIT primary key (SCENARIO_ID, BON_ID, BON_DAT, WUP_ID, MANDANT_ID)
)COMMENT='Contains the scenario hits - a relationship between receipts and potential fraud scenario'
;