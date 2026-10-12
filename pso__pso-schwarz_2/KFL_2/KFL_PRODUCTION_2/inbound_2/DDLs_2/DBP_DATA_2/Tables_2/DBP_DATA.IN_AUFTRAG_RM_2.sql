create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.IN_AUFTRAG_RM_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
	AUFTRAG_RM_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Rückmeldung aus rueck',
	AUFTRAG_RM_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Positionsid der Rückmeldung aus rmzhl',
	AUFTRAG_ID VARCHAR(20) COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
	CO_LEISTUNGSART_ID VARCHAR(7) COLLATE 'en-ci' COMMENT 'ID der CO-Leistungsart der Rückmeldung aus dem Quellfeld learr. Referenztabelle ist in_l_leistungsart_2',
	STORNO_FG NUMBER(38,0) NOT NULL COMMENT 'Flag = 1 für stornierten Beleg aus dem Quellfeld stokz',
	STORNO_ZAEHLER NUMBER(38,0) NOT NULL COMMENT 'Rückmeldezähler der stornierten Rückmeldung aus dem Quellfeld stzhl',
	DAT_BUCH DATE NOT NULL COMMENT 'Buchungsdatum',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TEIL_END_RM VARCHAR(1) COMMENT 'Teil-/Endrückmeldung (X = Endrückmeldung, 1 = Automatische Endrückmeldung, leer = Teilrückmeldung)',
	MENGE_ARBEIT_IST NUMBER(38,5) COMMENT 'Istarbeit - actual work done for this order',
	MENGE_ARBEIT_IST_EINH_ID VARCHAR(3) COMMENT 'istarbeit Masseinheit - unit_2 in which the actual work for this order is measured',
	DATZEIT_DURCHFUEHRUNG_ENDE TIMESTAMP_NTZ(9) COMMENT 'Rückgemeldeter Endzeitpunkt der Durchführung',
	constraint PK_IN_AUFTRAG_RM primary key (MANDANT_ID, AUFTRAG_RM_ID, AUFTRAG_RM_POS_ID)
)COMMENT='LIS - Auftrags-Rückmeldungen aus der Quelle SAP Industrie afru'
;
