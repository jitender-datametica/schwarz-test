CREATE OR REPLACE TABLE EKC_ZEK_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
	ZEK_ID VARCHAR(3) COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
	EIGENMARKE_FG NUMBER(38,0) COMMENT 'Flag Eigenmarke (wenn zek_id (Verhandler) und zek_vat_id (Verantwortlicher) in der Tabelle art_1 nicht identisch sind, wird das Flag auf 1 gesetzt (Eigenmarke-Artikel_1))',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_EKC_ZEK primary key (MANDANT_ID, ART_ID)
)COMMENT='ETL-Process table. Is used in the loading of table DBP_DATA.ARTBEW_MO_EK_CP_SUM.'
;