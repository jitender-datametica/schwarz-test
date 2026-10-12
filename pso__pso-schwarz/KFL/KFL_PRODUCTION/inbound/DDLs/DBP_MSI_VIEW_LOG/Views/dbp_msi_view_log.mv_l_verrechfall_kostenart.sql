CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_verrechfall_kostenart(
	VERRECHFALL_KOSTENART_ID,
	VERRECHNUNGSART_ID,
	VERRECHFALL_KOSTENTYP_ID
)AS
--08.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage
--28.04.2021, SPEC0091861, AP0073899, dknop, adding verrechnungsart_id, verrechfall_kostentyp_id
-- 10-05-2022, AP0125093, dknop,removing mandant_id
-- 07-06-2022, AP0112140_SPEC0155506, dknop, adding dummy record
-- 26-06-2024, dknop, adding new kostenart_id
SELECT

 v01.verrechfall_kostenart_id
,v01.verrechnungsart_id
,v01.verrechfall_kostentyp_id
FROM dbp_view.v_l_verrechfall_kostenart v01
GROUP BY 
 v01.verrechfall_kostenart_id
,v01.verrechnungsart_id
,v01.verrechfall_kostentyp_id

UNION

SELECT
 'K/NA'
,'K/NA'
,'K/NA'
FROM dbp_view.v_l_verrechfall_kostenart v01
GROUP BY 
 v01.verrechfall_kostenart_id
,v01.verrechnungsart_id
,v01.verrechfall_kostentyp_id

UNION
SELECT'MDIES','M',NULL

UNION
SELECT'MSTRO','M',NULL

UNION
SELECT'MGAS','M',NULL

UNION
SELECT'MMAUT','M',NULL

UNION
SELECT'MKUEH','M',NULL;