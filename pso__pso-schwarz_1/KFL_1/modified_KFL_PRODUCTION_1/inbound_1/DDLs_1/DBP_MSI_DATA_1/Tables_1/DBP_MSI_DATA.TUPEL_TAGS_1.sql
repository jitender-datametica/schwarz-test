CREATE TABLE DBP_MSI_DATA.TUPEL_TAGS_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	MATCHING_ID INTEGER NOT NULL COMMENT 'Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden',
	TUPEL_TAG VARCHAR(200) NOT NULL DEFAULT '-1' COMMENT 'Freitext, der vom User matching_ids zugeordnet wird',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='Pflege produktspezifischer Kurzinformationen zur Sortimentsarbeit durch User im Frontend'
;