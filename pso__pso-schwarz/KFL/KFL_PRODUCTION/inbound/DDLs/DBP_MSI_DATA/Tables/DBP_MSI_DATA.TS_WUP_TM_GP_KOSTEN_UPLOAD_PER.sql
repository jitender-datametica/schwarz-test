create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_WUP_TM_GP_KOSTEN_UPLOAD_PER (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_GP_ID VARCHAR(30) NOT NULL COMMENT 'ID des Geschäftspartners. Aus plkd.nr  (hier: Spedition)',
	TMS_GP_TYP_CD VARCHAR(3) NOT NULL COMMENT 'Geschäftspartnertyp. L- Lager, S - Spediteur, 0(null) - Markt(Kunde)     (hier: nur Speditionen)',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum  (hier: nur Werk)',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	KOSTEN_UPLOAD_FG NUMBER(38,0) COMMENT 'Flag: für Touren die von einer gg. Spedition aus einem gg. VZ gefahren werden, werden Daten in der Tabelle transportation_unit_kosten_upload erwartet',
	DAT_BIS DATE NOT NULL COMMENT 'Gültig bis',
	DAT_VON DATE COMMENT 'Gültig von',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_WUP_TM_GP_KOSTEN_UPLOAD_PER primary key (MANDANT_ID, SYSTEM_ID, TMS_GP_ID, TMS_GP_TYP_CD, WUP_ID, NB_ID, DAT_BIS)
)COMMENT='Transaction Services Table - User can maintain when to expect a record in Upload Table (dbp_data.transportation_unit_kosten)  for a given TDL/DC combination'
;
