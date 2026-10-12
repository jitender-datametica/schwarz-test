create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WG_VERKETTUNG_HIERARCHIE_ZU_PER_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	WG_VERKETT_ID NUMBER(38,0) NOT NULL COMMENT 'Warengruppenverkettungskennzeichen',
	WG_VERKETT_HIER_ID NUMBER(38,0) NOT NULL COMMENT 'LVS:Warengruppenverkettungshierarchie',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Format JJJJ-MM_1-TT ',
	DAT_BIS DATE COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Warengruppenverkettungshierarchie zuordnen'
;
