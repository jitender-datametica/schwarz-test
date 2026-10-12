create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_METRIC_SELECTOR_1(
	METRIC_SELECTOR_ID COMMENT 'Column for Metric Selector Identifier',
	METRIC_SELECTOR_NAME COMMENT 'Description for Metric Selector',
	METRIC_SELECTOR_NAME_DE COMMENT 'Description for Metric Selector in German',
	METRIC_SELECTOR_NAME_EN COMMENT 'Description for Metric Selector in English'
) COMMENT='Lookup/mapping table for the Technical Attribute Metric Selector (usage: Live Turnover)'
 as SELECT
1::NUMBER(38,0) AS metric_selector_id
,'IST'::VARCHAR(100) AS metric_selector_name
,'IST'::VARCHAR(100) AS metric_selector_name_de
,'ACT'::VARCHAR(100) AS metric_selector_name_en
UNION ALL 
SELECT
2::NUMBER(38,0) AS metric_selector_id
,'VJ'::VARCHAR(100) AS metric_selector_name
,'VJ'::VARCHAR(100) AS metric_selector_name_de
,'PY'::VARCHAR(100) AS metric_selector_name_en
UNION ALL 
SELECT
3::NUMBER(38,0) AS metric_selector_id
,'Δ VJ'::VARCHAR(100) AS metric_selector_name
,'Δ VJ'::VARCHAR(100) AS metric_selector_name_de
,'Δ PY'::VARCHAR(100) AS metric_selector_name_en
UNION ALL 
SELECT
4::NUMBER(38,0) AS metric_selector_id
,'Δ VJ %'::VARCHAR(100) AS metric_selector_name
,'Δ VJ %'::VARCHAR(100) AS metric_selector_name_de
,'Δ PY %'::VARCHAR(100) AS metric_selector_name_en
;