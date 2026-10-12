create or replace TABLE KFL_PRODUCTION.DBP_DATA.BAUSTEIN_WUP_ZU_PER_2 (
	BAUSTEIN_ID NUMBER(18,0) NOT NULL COMMENT 'ID eines Sortimentsbausteins',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT_BIS DATE NOT NULL COMMENT 'Ende des Gültigkeitszeitraums Format ''YYYY-MM_2-DD''',
	DAT_VON DATE COMMENT 'Beginn des Gültigkeitszeitraums Format ''YYYY-MM_2-DD''',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BAUSTEIN_WUP_ZU_PER primary key (MANDANT_ID, WUP_ID, NB_ID, DAT_BIS, BAUSTEIN_ID)
)COMMENT='TP2/7 AIS - Zuordnung Baustein zu Wup_2 - MULTISET'
;