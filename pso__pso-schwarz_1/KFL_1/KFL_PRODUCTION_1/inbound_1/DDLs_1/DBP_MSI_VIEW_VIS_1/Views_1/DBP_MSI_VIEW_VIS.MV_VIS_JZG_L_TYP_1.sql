CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_L_TYP_1(
	TYP_ID,
	TYP_BEZ,
	TYP_BEZ_CZ,
	TYP_BEZ_SK,
	TYP_BEZ_HR,
	TYP_BEZ_PL,
	TYP_BEZ_RO,
	TYP_BEZ_BG
) AS
 
/*	JZG LOOKUP : Jahreszielgespräch Typ (Ebene)
	2023-02-15 ssch0611 : Setup inkl. Translations AP0144461
	2023-10-18 ssch0611 : Review Syntax
	2024-01-11 ssch0611 : Release version
*/
 
SELECT
  $1::INTEGER AS TYP_ID 
, $2::STRING AS TYP_BEZ
, $3::STRING AS TYP_BEZ_CZ
, $4::STRING AS TYP_BEZ_SK
, $5::STRING AS TYP_BEZ_HR
, $6::STRING AS TYP_BEZ_PL
, $7::STRING AS TYP_BEZ_RO
, $8::STRING AS TYP_BEZ_BG
FROM ( 
	SELECT 
	0, 'Filiale', 'Filiálka', 'Filiálka', 'Poslovnica', 'Market', 'Magazin', 'Филиал'
	UNION ALL SELECT 
	1, 'Abteilung', 'Oddělení', 'Oddelenie', 'Odjel', 'Dział', 'Departament', 'Отдел'
	UNION ALL SELECT 
	2, 'HWG', 'HWG', 'HWG', 'HWG', 'GGT', 'HWG', 'HWG'
	UNION ALL SELECT 
	3, 'OWG', 'OWG', 'OWG', 'OWG', 'NGT', 'OWG', 'OWG'
) jzg;