CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_UMLAGERUNG_STATUS_KZ_1 (
	UMLAGERUNG_STATUS_KZ COMMENT 'Kennzeichen für Umlagerungsstatus', 
	UMLAGERUNG_STATUS_KZ_BEZ COMMENT 'Bezeichnung für Umlagerungsstatus'
	) COMMENT = 'Lookup für Kennzeichen von Umlagerungsstatus' 
AS
/* 
2024-04-30 muellerpatri : Initiale Erstellung, AP0212768 
2025-09-11 tekin: Korrektur Kennzeichen
*/
SELECT umlagerung_status_kz
	, umlagerung_status_kz_bez
FROM (VALUES 
	('O', 'Offen')
	, ('S', 'Storniert') 
	, ('W', 'WE') 
	) AS usk (umlagerung_status_kz, umlagerung_status_kz_bez)
;
