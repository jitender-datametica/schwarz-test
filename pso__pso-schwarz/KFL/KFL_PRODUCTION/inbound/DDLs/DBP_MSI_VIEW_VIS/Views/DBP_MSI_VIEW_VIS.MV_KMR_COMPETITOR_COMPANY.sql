CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_COMPETITOR_COMPANY(
	MANDANT_ID,
	COMPETITOR_FG,
	SYSTEM_NAME,
	COMPETITOR_COMPANY_ID,
	COMPETITOR_COMPANY_CODE,
	COMPETITOR_COMPANY_NAME,
	COMPETITOR_SORT_ID
) AS

/*
	KMR Google : Wettbewerber Company
	Sorting : Manuelle Zuordnung (COMPETITOR_SORT) duch Fachbereich
	2024-02-27 : Review, Neue Gruppierung
	2025-05-06 muellerpatri : Änderung von SID auf ID
	2025-09-09 ssch0611 : Review CASE + Neue Zuordnungen
*/

SELECT rco.mandant_id
	, rco.competitor_fg
	, rco.ext_system_name       AS system_name
	, rco.ext_retail_company_id AS competitor_company_id
	, rco.retail_company_code   AS competitor_company_code
	, rco.retail_company_name   AS competitor_company_name
	/* Gruppierung, Mapping, Sortierung pro Land */
	, CASE rco.mandant_id
		WHEN 1 THEN CASE 
			WHEN ext_retail_company_id =   7 THEN 10 -- Lidl DE
			WHEN ext_retail_company_id IN (17,232,233,237,239,240,241,315) THEN 20 -- Edeka Group DE 
			WHEN ext_retail_company_id = 229 THEN 30 -- Aldi Nord DE 
			WHEN ext_retail_company_id = 228 THEN 40 -- Aldi Süd DE
			WHEN ext_retail_company_id =  16 THEN 50 -- Rewe DE
			WHEN ext_retail_company_id = 111 THEN 60 -- Globus DE
			ELSE 999 END -- 11 Aldi DE
		WHEN 2 THEN CASE 
			WHEN ext_retail_company_id =  77 THEN 10 -- Lidl CZ
			WHEN ext_retail_company_id = 222 THEN 20 -- Albert CZ
			WHEN ext_retail_company_id = 101 THEN 30 -- Penny CZ
			WHEN ext_retail_company_id = 102 THEN 40 -- Tesco CZ
			WHEN ext_retail_company_id = 106 THEN 50 -- Billa CZ
			WHEN ext_retail_company_id = 110 THEN 60 -- Globus CZ
			WHEN ext_retail_company_id IN (98,246) THEN 70 -- Coop Group CZ
			ELSE 999 END 
		WHEN 3 THEN CASE 
			WHEN ext_retail_company_id= 51 THEN 10 -- Lidl PL
			WHEN ext_retail_company_id=117 THEN 20 -- Biedronka PL
			WHEN ext_retail_company_id= 96 THEN 30 -- Auchan PL
			WHEN ext_retail_company_id IN (94,219,442) THEN 40 -- Carrefour Group PL
			WHEN ext_retail_company_id=100 THEN 50 -- Netto PL
			WHEN ext_retail_company_id= 63 THEN 60 -- Aldi PL
			WHEN ext_retail_company_id=190 THEN 70 -- Dino PL
			WHEN ext_retail_company_id=220 THEN 80 -- Stokrotka PL
		ELSE 999 END 
		WHEN 4 THEN CASE 
			WHEN ext_retail_company_id=238 THEN 10 -- Linella MD
			WHEN ext_retail_company_id=242 THEN 20 -- Metro MD
			WHEN ext_retail_company_id=236 THEN 30 -- Green Hills Market MD
			WHEN ext_retail_company_id=243 THEN 40 -- NR 1 MD
			WHEN ext_retail_company_id=234 THEN 50 -- Fidesco MD
			WHEN ext_retail_company_id=235 THEN 60 -- Fourchette MD
			WHEN ext_retail_company_id=248 THEN 70 -- Velmart MD
		ELSE 999 END 
		WHEN 5 THEN CASE 
			WHEN ext_retail_company_id =  80 THEN 10 -- Lidl SK
			WHEN ext_retail_company_id IN (99,443,484) THEN 20 -- Coop Group SK
			WHEN ext_retail_company_id = 104 THEN 30 -- Tesco SK
			WHEN ext_retail_company_id = 107 THEN 40 -- Billa SK
			WHEN ext_retail_company_id = 119 THEN 50 -- Fresh SK
			WHEN ext_retail_company_id = 247 THEN 60 -- Terno SK
		ELSE 999 END --109 CBA SK
		WHEN 6 THEN CASE 
			WHEN ext_retail_company_id =  76 THEN 10 -- Lidl HR
			WHEN ext_retail_company_id =  83 THEN 20 -- Konzum HR
			WHEN ext_retail_company_id = 115 THEN 30 -- Plodine HR
			WHEN ext_retail_company_id = 122 THEN 40 -- Interspar HR
			WHEN ext_retail_company_id = 112 THEN 50 -- Spar HR
			WHEN ext_retail_company_id = 121 THEN 60 -- Tommy HR
			WHEN ext_retail_company_id = 194 THEN 70 -- Euro Spin HR
		ELSE 999 END 
		WHEN 7 THEN CASE 
			WHEN ext_retail_company_id =  79 THEN 10 -- Lidl RO
			WHEN ext_retail_company_id IN (95,440,441,445) THEN 20 -- Carrefour Group RO
			WHEN ext_retail_company_id = 116 THEN 30 -- Profi RO
			WHEN ext_retail_company_id =  86 THEN 40 -- Penny RO
			WHEN ext_retail_company_id =  97 THEN 50 -- Auchan RO
			WHEN ext_retail_company_id = 114 THEN 60 -- Mega Image RO
		ELSE 999 END 
		WHEN 8 THEN CASE 
			WHEN ext_retail_company_id =  75 THEN 10 -- Lidl BG
			WHEN ext_retail_company_id = 105 THEN 20 -- Billa BG
			WHEN ext_retail_company_id = 118 THEN 30 -- Fantastico BG
			WHEN ext_retail_company_id = 245 THEN 40 -- T-Market BG
			WHEN ext_retail_company_id = 108 THEN 50 -- CBA BG
			WHEN ext_retail_company_id = 113 THEN 60 -- Metro BG
			WHEN ext_retail_company_id = 244 THEN 70 -- Parkmart BG
			ELSE 999 END 
		ELSE 0 
	END AS competitor_sort_id

FROM DBP_VIEW.V_RETAIL_COMPANY rco

WHERE rco.competitor_fg = 1
;