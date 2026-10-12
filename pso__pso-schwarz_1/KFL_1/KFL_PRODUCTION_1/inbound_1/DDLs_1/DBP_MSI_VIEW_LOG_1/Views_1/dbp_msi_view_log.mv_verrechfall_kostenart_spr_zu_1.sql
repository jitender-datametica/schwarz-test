CREATE OR REPLACE VIEW dbp_msi_view_log.mv_verrechfall_kostenart_spr_zu_1(
	VERRECHFALL_KOSTENART_ID,
	VERRECHFALL_KOSTENART_BEZ,
	VERRECHFALL_KOSTENART_BEZ_DE,
	VERRECHFALL_KOSTENART_BEZ_CZ,
	VERRECHFALL_KOSTENART_BEZ_SK,
	VERRECHFALL_KOSTENART_BEZ_HR,
	VERRECHFALL_KOSTENART_BEZ_PL,
	VERRECHFALL_KOSTENART_BEZ_RO,
	VERRECHFALL_KOSTENART_BEZ_B
)AS
--08.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_1
--10-05-2022, AP0125093, dknop,removing mandant_id
-- 07-06-2022, AP0112140_SPEC0155506, dknop, adding dummy_1 record
-- 26-06-2024, dknop, adding new kostenart_id

SELECT

v01.verrechfall_kostenart_id,
MAX(CASE WHEN v01.spr_id = 22 THEN v01.verrechfall_kostenart_bez END) AS verrechfall_kostenart_bez,                        -- standard == DE
MAX(CASE WHEN v01.spr_id = 22 THEN v01.verrechfall_kostenart_bez END) AS verrechfall_kostenart_bez_de,                                  -- DE
COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.verrechfall_kostenart_bez END),verrechfall_kostenart_bez_de) AS verrechfall_kostenart_bez_cz,    -- CZ
COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.verrechfall_kostenart_bez END),verrechfall_kostenart_bez_de) AS verrechfall_kostenart_bez_sk,    -- SK
COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.verrechfall_kostenart_bez END),verrechfall_kostenart_bez_de) AS verrechfall_kostenart_bez_hr,    -- HR
COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.verrechfall_kostenart_bez END),verrechfall_kostenart_bez_de) AS verrechfall_kostenart_bez_pl,    -- PL
COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.verrechfall_kostenart_bez END),verrechfall_kostenart_bez_de) AS verrechfall_kostenart_bez_ro,    -- RO
COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.verrechfall_kostenart_bez END),verrechfall_kostenart_bez_de) AS verrechfall_kostenart_bez_b
FROM dbp_view.v_verrechfall_kostenart_spr_zu_1 v01

GROUP BY v01.verrechfall_kostenart_id

UNION

SELECT
 'K/NA'
,'manueller Upload'
,'manueller Upload'
,'manueller Upload'
,'manueller Upload'
,'manueller Upload'
,'manueller Upload'
,'manueller Upload'
,'manueller Upload'
FROM dbp_view.v_verrechfall_kostenart_spr_zu_1 v01
GROUP BY v01.verrechfall_kostenart_id

UNION

SELECT
 'MDIES'
,'manuelle Berechnung Diesel-Anteil'
,'manuelle Berechnung Diesel-Anteil'
,'manuelle Berechnung Diesel-Anteil'
,'manuelle Berechnung Diesel-Anteil'
,'manuelle Berechnung Diesel-Anteil'
,'manuelle Berechnung Diesel-Anteil'
,'manuelle Berechnung Diesel-Anteil'
,'manuelle Berechnung Diesel-Anteil'

UNION

SELECT
 'MSTRO'
,'manuelle Berechnung Strom-Anteil'
,'manuelle Berechnung Strom-Anteil'
,'manuelle Berechnung Strom-Anteil'
,'manuelle Berechnung Strom-Anteil'
,'manuelle Berechnung Strom-Anteil'
,'manuelle Berechnung Strom-Anteil'
,'manuelle Berechnung Strom-Anteil'
,'manuelle Berechnung Strom-Anteil'

UNION

SELECT
 'MGAS'
,'manuelle Berechnung Gas-Anteil'
,'manuelle Berechnung Gas-Anteil'
,'manuelle Berechnung Gas-Anteil'
,'manuelle Berechnung Gas-Anteil'
,'manuelle Berechnung Gas-Anteil'
,'manuelle Berechnung Gas-Anteil'
,'manuelle Berechnung Gas-Anteil'
,'manuelle Berechnung Gas-Anteil'

UNION

SELECT
 'MMAUT'
,'manuelle Berechnung Maut-Anteil'
,'manuelle Berechnung Maut-Anteil'
,'manuelle Berechnung Maut-Anteil'
,'manuelle Berechnung Maut-Anteil'
,'manuelle Berechnung Maut-Anteil'
,'manuelle Berechnung Maut-Anteil'
,'manuelle Berechnung Maut-Anteil'
,'manuelle Berechnung Maut-Anteil'

UNION

SELECT
 'MKUEH'
,'manuelle Berechnung Kühlung-Anteil'
,'manuelle Berechnung Kühlung-Anteil'
,'manuelle Berechnung Kühlung-Anteil'
,'manuelle Berechnung Kühlung-Anteil'
,'manuelle Berechnung Kühlung-Anteil'
,'manuelle Berechnung Kühlung-Anteil'
,'manuelle Berechnung Kühlung-Anteil'
,'manuelle Berechnung Kühlung-Anteil'
;