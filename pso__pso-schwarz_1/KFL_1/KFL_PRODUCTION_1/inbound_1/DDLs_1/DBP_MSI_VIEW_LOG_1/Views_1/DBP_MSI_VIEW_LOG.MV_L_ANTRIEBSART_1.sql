create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_L_ANTRIEBSART_1(
	ANTRIEBSART_ID,
	ANTRIEBSART_BEZ
) as
--2026-02-27, AP0304701, dknop, initial
SELECT
-1 AS antriebsart_id
,'' AS antriebsart_bez
UNION
SELECT
0 AS antriebsart_id
,'keine Zuordnung' AS antriebsart_bez
UNION
SELECT
1 AS antriebsart_id
,'Diesel' AS antriebsart_bez
UNION
SELECT
2 AS antriebsart_id
,'Elektro' AS antriebsart_bez
UNION
SELECT
3 AS antriebsart_id
,'Gas' AS antriebsart_bez
UNION
SELECT
4 AS antriebsart_id
,'Wasserstoff' AS antriebsart_bez
;
