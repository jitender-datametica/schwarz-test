create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_GESCHAEFTSVORFALL_SPR_ZU(
	MANDANT_ID,
	GESCHAEFTSVORFALL_ID,
	GESCHAEFTSVORFALL_BEZ,
	GESCHAEFTSVORFALL_BEZ_DE,
	GESCHAEFTSVORFALL_BEZ_CZ,
	GESCHAEFTSVORFALL_BEZ_SK,
	GESCHAEFTSVORFALL_BEZ_HR,
	GESCHAEFTSVORFALL_BEZ_PL,
	GESCHAEFTSVORFALL_BEZ_RO,
	GESCHAEFTSVORFALL_BEZ_BG
) as
SELECT DISTINCT
  v01.mandant_id
, v01.geschaeftsvorfall_id
, MAX(CASE WHEN spr_id = 22 THEN geschaeftsvorfall_bez END) AS geschaeftsvorfall_bez -- standard == DE
, MAX(CASE WHEN spr_id = 22 THEN geschaeftsvorfall_bez END) AS geschaeftsvorfall_bez_de -- DE
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de) AS geschaeftsvorfall_bez_cz -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de) AS geschaeftsvorfall_bez_sk -- SK
, COALESCE(MAX(CASE WHEN spr_id = 65 THEN geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de) AS geschaeftsvorfall_bez_hr -- HR
, COALESCE(MAX(CASE WHEN spr_id = 90 THEN geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de) AS geschaeftsvorfall_bez_pl -- PL
, COALESCE(MAX(CASE WHEN spr_id = 95 THEN geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de) AS geschaeftsvorfall_bez_ro -- RO
, COALESCE(MAX(CASE WHEN spr_id = 18 THEN geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de) AS geschaeftsvorfall_bez_bg -- BG
FROM dbp_view.v_geschaeftsvorfall_spr_zu v01

GROUP BY
v01.mandant_id
, v01.geschaeftsvorfall_id

UNION

SELECT
  v01.mandant_id
, '00' AS geschaeftsvorfall_id
, 'kein BBY' AS geschaeftsvorfall_bez -- standard == DE
, 'non-BBY' AS geschaeftsvorfall_bez_de -- DE
, 'non-BBY' AS geschaeftsvorfall_bez_cz -- CZ
, 'non-BBY' AS geschaeftsvorfall_bez_sk -- SK
, 'non-BBY' AS geschaeftsvorfall_bez_hr -- HR
, 'non-BBY' AS geschaeftsvorfall_bez_pl -- PL
, 'non-BBY' AS geschaeftsvorfall_bez_ro -- RO
, 'non-BBY' AS geschaeftsvorfall_bez_bg -- BG
FROM dbp_view.v_mandant v01
GROUP BY v01.mandant_id;