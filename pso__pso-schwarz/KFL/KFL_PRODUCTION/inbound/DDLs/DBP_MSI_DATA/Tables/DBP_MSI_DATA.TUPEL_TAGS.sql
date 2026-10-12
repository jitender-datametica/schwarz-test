CREATE TABLE DBP_MSI_DATA.TUPEL_TAGS (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	MATCHING_ID NUMBER(38,0) NOT NULL COMMENT 'Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden',
	TUPEL_TAG VARCHAR(200) NOT NULL DEFAULT '-1' COMMENT 'Freitext, der vom User matching_ids zugeordnet wird',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='Pflege produktspezifischer Kurzinformationen zur Sortimentsarbeit durch User im Frontend'
;