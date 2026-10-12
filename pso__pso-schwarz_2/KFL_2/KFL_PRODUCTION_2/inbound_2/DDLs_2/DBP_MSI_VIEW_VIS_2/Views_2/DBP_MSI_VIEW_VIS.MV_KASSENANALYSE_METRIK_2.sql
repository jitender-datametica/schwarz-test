CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KASSENANALYSE_METRIK_2(
	KASSENANALYSE_GRP_ID,
	KASSENANALYSE_KENNZAHL_ID,
	KASSENANALYSE_METRIK_ID,
	KASSENANALYSE_METRIK_BEZ,
	KASSENANALYSE_METRIK_BEZ_CZ,
	KASSENANALYSE_METRIK_BEZ_SK,
	KASSENANALYSE_METRIK_BEZ_HR,
	KASSENANALYSE_METRIK_BEZ_PL,
	KASSENANALYSE_METRIK_BEZ_RO,
	KASSENANALYSE_METRIK_BEZ_BG
) AS 

/* Kassenabschluss Relationen : Metriken und Metrikegruppen (Kennzahlenblöcke)
 2025-01-09 muellerpatri : Initial. AP0154509 
 	2025-11-27 ssch0611 : Temporär > Deutscher Text für alle 
*/ 

SELECT $1::INTEGER AS KASSENANALYSE_GRP_ID
	, $2::INTEGER  AS KASSENANALYSE_KENNZAHL_ID
	, (KASSENANALYSE_GRP_ID * 100) + KASSENANALYSE_KENNZAHL_ID AS KASSENANALYSE_METRIK_ID
	, $3::STRING  AS KASSENANALYSE_METRIK_BEZ
	, $3::STRING  AS KASSENANALYSE_METRIK_BEZ_CZ
	, $3::STRING  AS KASSENANALYSE_METRIK_BEZ_SK
	, $3::STRING  AS KASSENANALYSE_METRIK_BEZ_HR
	, $3::STRING  AS KASSENANALYSE_METRIK_BEZ_PL
	, $3::STRING  AS KASSENANALYSE_METRIK_BEZ_RO
	, $3::STRING  AS KASSENANALYSE_METRIK_BEZ_BG
FROM ( 
/* Block 0 Filiale (ohne Info und Imbiss) */
	SELECT           0, 10, 'Umsatz netto Gesamt', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 0, 20, 'Anzahl Kunden (Bons) Gesamt', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'


	UNION ALL SELECT 0, 50, 'Bonzeilen je Kunde (Bons) Gesamt', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 0, 60, 'Ø-Bon Gesamt', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 1 Filiale inkl. Info und Imbiss */
	UNION ALL SELECT 1, 10, 'Umsatz netto Gesamt', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 1, 20, 'Anzahl Kunden (Bons) Gesamt', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'


	UNION ALL SELECT 1, 50, 'Bonzeilen je Kunde (Bons) Gesamt', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 1, 60, 'Ø-Bon Gesamt', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 2 */
	UNION ALL SELECT 2, 10, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 2, 20, 'Anzahl Kunden (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 2, 30, 'Umsatzanteil', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 2, 40, 'Kundenanteil (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 2, 50, 'Bonzeilen je Kunde (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 2, 60, 'Ø-Bon', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 3 */
	UNION ALL SELECT 3, 10, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 3, 20, 'Anzahl Kunden (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 3, 30, 'Umsatzanteil', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 3, 40, 'Kundenanteil (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 3, 50, 'Bonzeilen je Kunde (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 3, 60, 'Ø-Bon', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 4 */
	UNION ALL SELECT 4, 10, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 4, 20, 'Anzahl Kunden (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 4, 30, 'Umsatzanteil', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 4, 40, 'Kundenanteil (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 4, 50, 'Bonzeilen je Kunde (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 4, 60, 'Ø-Bon', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 5 */
	UNION ALL SELECT 5, 10, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 5, 20, 'Anzahl Kunden (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 5, 30, 'Umsatzanteil', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 5, 40, 'Kundenanteil (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 5, 50, 'Bonzeilen je Kunde (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 5, 60, 'Ø-Bon', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 6 K-Scan Gesamt */
	UNION ALL SELECT 6, 10, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 6, 20, 'Anzahl Kunden (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 6, 30, 'Umsatzanteil', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 6, 40, 'Kundenanteil (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 6, 50, 'Bonzeilen je Kunde (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 6, 60, 'Ø-Bon', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 7 */
	UNION ALL SELECT 7, 10, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 7, 20, 'Anzahl Kunden (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 7, 30, 'Umsatzanteil', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 7, 40, 'Kundenanteil (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 7, 50, 'Bonzeilen je Kunde (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 7, 60, 'Ø-Bon', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 8 */
	UNION ALL SELECT 8, 10, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 8, 20, 'Anzahl Kunden (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 8, 30, 'Umsatzanteil', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 8, 40, 'Kundenanteil (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 8, 50, 'Bonzeilen je Kunde (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 8, 60, 'Ø-Bon', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
/* Block 9 */
	UNION ALL SELECT 9, 10, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 9, 20, 'Anzahl Kunden (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 9, 30, 'Umsatzanteil', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 9, 40, 'Kundenanteil (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 9, 50, 'Bonzeilen je Kunde (Bons)', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 9, 60, 'Ø-Bon', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
) metrik_group;