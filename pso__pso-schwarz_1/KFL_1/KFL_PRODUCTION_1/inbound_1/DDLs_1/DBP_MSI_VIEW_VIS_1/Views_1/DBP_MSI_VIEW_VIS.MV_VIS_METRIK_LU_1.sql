CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_METRIK_LU_1(
	METRIK_ID,
	METRIK_GRP,
	METRIK_BEZ,
	METRIK_BEZ_DE,
	METRIK_BEZ_CZ,
	METRIK_BEZ_SK,
	METRIK_BEZ_HR,
	METRIK_BEZ_PL,
	METRIK_BEZ_RO,
	METRIK_BEZ_BG
) AS

/*
	VIS LOOKUP : Metriken/Beschriftungen gruppiert nach Thema
	2025-08-12 ssch0611 : Initial. Leistung [AP0273081]
*/

SELECT $1::INTEGER AS METRIK_ID
	, $2::INTEGER AS METRIK_GRP /* 1 = Leistung */
	, $3::STRING  AS METRIK_BEZ /* default = DE */
	, $3::STRING  AS METRIK_BEZ_DE
	, $4::STRING  AS METRIK_BEZ_CZ
	, $5::STRING  AS METRIK_BEZ_SK
	, $6::STRING  AS METRIK_BEZ_HR
	, $7::STRING  AS METRIK_BEZ_PL
	, $8::STRING  AS METRIK_BEZ_RO
	, $9::STRING  AS METRIK_BEZ_BG
FROM (
	SELECT             1, 1, 'Leistung', 'Výkon', 'Výkon', 'Produktivnost', 'Produktywność', 'Eficienţă', 'продуктивност'
	UNION ALL SELECT 100, 1, 'Umsatz netto', 'Obrat Netto', 'Obrat netto', 'Neto promet', 'Obrót netto', 'Vânzare netă', 'Оборот нето'
	UNION ALL SELECT 110, 1, 'IST', 'IST', 'Hodiny', 'IST', 'Jest', 'IST', 'IST'
	UNION ALL SELECT 140, 1, 'Hochrechnung', 'Prognozy', 'Odhad', 'Procjena', 'Prognoza', 'Forecast', 'Прогноза'
	UNION ALL SELECT 130, 1, 'Plan', 'Plán', 'Plán', 'Plan', 'Plan', 'Plan', 'План'
	UNION ALL SELECT 140, 1, 'VJ', 'VJ', 'VJ', 'PrG', 'PR', 'AA', 'ПГ'
	UNION ALL SELECT 200, 1, 'Nettostunden', 'Hodiny netto', 'Čisté hodiny', 'Neto sati', 'Godziny netto', 'Ore nete', 'Нето часове'
	UNION ALL SELECT 250, 1, 'Nettoleistung', 'Hodinový výkon', 'Čistý výkon', 'Neto produkt.', 'Produktyw. netto', 'Eficiență netă', 'Нето продукт.'
	UNION ALL SELECT 300, 1, 'Stunden_1', 'Hodiny', 'Hodiny', 'Sati', 'Godziny', 'Ore', 'Часове'
	UNION ALL SELECT 310, 1, 'Stunden_1 IST', 'Hodiny IST', 'Hodiny IST', 'Sati IST', 'Godziny Jest', 'Ore IST', 'Часове IST'
	UNION ALL SELECT 320, 1, 'Stunden_1 Hochrechnung', 'Hodiny Prognozy', 'Hodiny Odhad', 'Sati Procjena', 'Godziny Prognoza', 'Ore Forecast', 'Часове Прогноза'
	UNION ALL SELECT 330, 1, 'Stunden_1 Plan', 'Hodiny Plán', 'Hodiny Plán', 'Sati Plan', 'Godziny Plan', 'Ore Plan', 'Часове План'
	UNION ALL SELECT 340, 1, 'Stunden_1 VJ', 'Hodiny VJ', 'Hodiny VJ', 'Sati PrG', 'Godziny PR', 'Ore AA', 'Часове ПГ'

	UNION ALL SELECT 400, 1, 'Absatz', 'Množství', 'Množstvo', 'Količina', 'Liczba sztuk', 'Cantitate', 'Количество'
	UNION ALL SELECT 450, 1, 'Nettostückleistung', 'Čistý výkon na kus', 'Čistý kusový výkon', 'Neto produkt. po komadu', 'Produktyw. w szt.', 'Eficiență cantitativă', 'Нето прод. на бр. а-ли'
)
;