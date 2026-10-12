create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.IN_AUFTRAG_2 (
	AUFTRAG_ID VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
	AUFTRAGSART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Auftragsart aus auart',
	GESCHAEFTSBEREICH_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'Der Geschaeftsbereich ist eine_2 interne Organisationseinheit, fuer den eine_2 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber',
	IN_BUDGET_TYP_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Eindeutige ID eines Budgettyps',
	IN_MASSNAHME_TYP_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Eindeutige ID eins Massnahmetyps',
	AUFTRAG_TYP_ID NUMBER(38,0) COMMENT 'ID des Auftragstyps',
	PSP_ID NUMBER(38,0) COMMENT 'eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen',
	TECHN_PLATZ_ID VARCHAR(30) COLLATE 'en-ci' COMMENT 'Fachlicher Schlüssel des technischen Platzes aus tplnr. Referenz zur Tabelle techn_platz_per_2 (im Modell keine Darstellung der Beziehung) Wird compressed',
	WERK_ID NUMBER(38,0) COMMENT 'Numerischer Surrogate key für das Werk werks',
	PHAS_TECHN_ABSCHLUSS_FG NUMBER(38,0) NOT NULL COMMENT 'Flag = 1 bei technischem Abschluss. Quelle ist phas2',
	REF_OBJEKTART_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' DEFAULT '  ' COMMENT 'Teilstring aus dem Quellfeld objnr. Das Feld setzt sich aus Teil 1 (char(2)) und Teil 2 (Auftragsnummer) zusammen. Hier wird nur der alpha-Teil gespeichert.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	AUFTRAG_KURZTEXT VARCHAR(40) COMMENT 'Kurzbeschreibung des Auftrags',
	REFERENZ_AUFTRAG_ID VARCHAR(20) COLLATE 'en-ci' COMMENT 'Referenzauftragsnummer. If this order is derived from a previous order, then this is the ID of the previous order.',
	STANDORT_ID VARCHAR(10) COLLATE 'en-ci' COMMENT 'ID eines Standortes. Zuordnung Markt bei Pooling-Geräten (oder alphanumerischer Wert / \""POOL\"").',
	STANDORT_WERK_ID NUMBER(38,0) COMMENT 'Numerischer Surrogate key für das Werk werks - Plan where order should have been executed. Most of the times it is identical to WERK_ID.',
	KOSTENSTELLE_ID VARCHAR(10) COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle, aus kostl.',
	VERANTW_ARBEITSPLATZ_NAME VARCHAR(10) COMMENT 'Verantwortlicher Arbeitsplatz -  Main work center (SAP term)  for maintenance tasks. \n            A work center is an organizational unit_2 that defines where or by whom a maintenance activity is performed. Work centers can be machines, people, or production lines, for example.\n            In this column we have the work center that is assigned to a maintenance order at the HEADER level (on position a.k.a. \""order operation\"" level there can be other work centers).\n            The \""Name\"" is the identifier of the work place, there is no code or ID. The source system supports additional descriptions of these names, but they are not maintained by the business so as of May 2024, there is no lookup table with name-description combo',
	constraint PK_IN_AUFTRAG primary key (AUFTRAG_ID, MANDANT_ID)
)COMMENT='IMS - Auftragsstammdaten aus aufk'
;
