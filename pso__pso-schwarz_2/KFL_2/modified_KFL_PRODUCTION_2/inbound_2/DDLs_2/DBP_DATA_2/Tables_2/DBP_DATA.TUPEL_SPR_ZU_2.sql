CREATE TABLE DBP_DATA.TUPEL_SPR_ZU_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	MATCHING_ID INTEGER NOT NULL COMMENT 'Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden',
	KJWO_UPDATE INTEGER NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	TUPEL_BEZ VARCHAR(200) NOT NULL COMMENT 'Bezeichnung eines Tupels für EK SORT',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='Tupelbezeichnungen in Landessprache, Quelle der Tupel ist Tabelle tupel_mat_2'
;