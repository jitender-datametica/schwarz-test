CREATE OR REPLACE VIEW ldl_fe_mstr_master.v_metric_selector_2 (metric_selector_id
OPTIONS(description='Column for Metric Selector Identifier'), metric_selector_name
OPTIONS(description='Description for Metric Selector'), metric_selector_name_de
OPTIONS(description='Description for Metric Selector in German'), metric_selector_name_en
OPTIONS(description='Description for Metric Selector in English'))
OPTIONS(DESCRIPTION = `LOOKUP/MAPPING TABLE FOR THE TECHNICAL ATTRIBUTE METRIC SELECTOR (USAGE: LIVE TURNOVER)`) AS
SELECT 1 AS metric_selector_id,
 'IST' AS metric_selector_name,
 'IST' AS metric_selector_name_de,
 'ACT' AS metric_selector_name_en
UNION ALL
SELECT 2 AS metric_selector_id,
 'VJ' AS metric_selector_name,
 'VJ' AS metric_selector_name_de,
 'PY' AS metric_selector_name_en
UNION ALL
SELECT 3 AS metric_selector_id,
 'Δ VJ' AS metric_selector_name,
 'Δ VJ' AS metric_selector_name_de,
 'Δ PY' AS metric_selector_name_en
UNION ALL
SELECT 4 AS metric_selector_id,
 'Δ VJ %' AS metric_selector_name,
 'Δ VJ %' AS metric_selector_name_de,
 'Δ PY %' AS metric_selector_name_en;