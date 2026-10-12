create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.FLAG_SPR_ZU_2 (
	FLAG NUMBER(38,0) NOT NULL COMMENT 'Flag-Ausprägung. Kann 0 oder 1 sein',
	FLAG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Flagtyp. 1 steht für ja/nein',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	FLAG_BEZ VARCHAR(50) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Flags. Bei flag=1,flag_typ_id=1 und spr_id=22 ist die Bezeichnung ja',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_FLAG_SPR_ZU primary key (FLAG, FLAG_TYP_ID, SPR_ID)
)COMMENT='GEKU - universell einsetzbare Tabelle zur Zuweisung von Texten zu Flags'
;
