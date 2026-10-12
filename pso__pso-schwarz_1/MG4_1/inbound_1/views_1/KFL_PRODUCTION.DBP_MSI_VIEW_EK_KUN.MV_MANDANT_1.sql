create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_MANDANT_1(
	MANDANT_SORT_ID,
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	DEFAULT_WRG,
	MANDANT_SAP_ID,
	SPAET_LIEF_TAGE
) as 
SELECT 
  v01.mandant_sort_id
, v01.mandant_id
, v01.mandant_bez
, v01.mandant_kbez
, v01.default_wrg
, v01.mandant_sap_id
, v01.spaet_lief_tage

FROM dbp_view.v_mandant_1 v01

UNION ALL

SELECT
 99 AS mandant_sort_id
, -1 AS mandant_id
, 'unknown' AS mandant_bez
, '-' AS mandant_kbez
, '' AS default_wrg
, -1 AS mandant_sap_id
, -1 AS spaet_lief_tage

FROM dbp_view.v_mandant_1 v02
WHERE mandant_id = 1
;