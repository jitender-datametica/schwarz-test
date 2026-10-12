create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.L_AKTION_TYP_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	AKTION_TYP_ID VARCHAR(4) NOT NULL COMMENT 'ID des Typs die Art_2 der Aktion.',
	AKTION_TYP_BEZ VARCHAR(200) COMMENT 'Bezeichnung des Typs die Art_2 der Aktion.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_L_AKTION_TYP primary key (AKTION_TYP_ID, MANDANT_ID)
)COMMENT='Lookup-Tabelle für den Typ der Aktion. KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = Promotion die bei einem externen Partner erworben wurde (bspw.Partner Coupon, SMP Coupon, Gutschein_2 von Partner); KPB = Promotion erhalbar über Payback Card, nur im Polen gültig,'
;
