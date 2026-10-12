create or replace TABLE KFL_PRODUCTION.DBP_DATA.TUPEL_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	MATCHING_ID NUMBER(38,0) NOT NULL COMMENT 'Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden',
	KJWO_UPDATE NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	TUPEL_BEZ VARCHAR(200) NOT NULL COMMENT 'Bezeichnung eines Tupels für EK SORT',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='Tupelbezeichnungen in Landessprache, Quelle der Tupel ist Tabelle tupel_mat'
;