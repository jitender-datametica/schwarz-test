CREATE OR REPLACE TABLE EKC_ZEK (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH.',
	ART_ID INTEGER NOT NULL COMMENT 'Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
	ZEK_ID VARCHAR(3) COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
	EIGENMARKE_FG INTEGER COMMENT 'Flag Eigenmarke (wenn zek_id (Verhandler) und zek_vat_id (Verantwortlicher) in der Tabelle art nicht identisch sind, wird das Flag auf 1 gesetzt (Eigenmarke-Artikel))',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_EKC_ZEK primary key (MANDANT_ID, ART_ID)
)COMMENT='ETL-Process table. Is used in the loading of table DBP_DATA.ARTBEW_MO_EK_CP_SUM.'
;