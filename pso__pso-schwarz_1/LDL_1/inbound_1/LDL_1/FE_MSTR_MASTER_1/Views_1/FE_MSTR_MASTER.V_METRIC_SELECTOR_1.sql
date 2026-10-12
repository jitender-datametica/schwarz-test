CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_METRIC_SELECTOR_1 (
metric_selector_id COMMENT 'Column for Metric Selector Identifier'
,metric_selector_name COMMENT 'Description for Metric Selector'
,metric_selector_name_de COMMENT 'Description for Metric Selector in German'
,metric_selector_name_en COMMENT 'Description for Metric Selector in English'
) COMMENT = 'Lookup/mapping table for the Technical Attribute Metric Selector (usage: Live Turnover)' AS SELECT
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