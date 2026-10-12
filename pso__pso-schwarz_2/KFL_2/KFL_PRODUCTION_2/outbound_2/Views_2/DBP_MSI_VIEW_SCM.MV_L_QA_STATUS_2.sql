CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_qa_status_2 (qa_status, qa_status_bez) AS SELECT 'A' AS
 qa_status,
 'Konzession' AS qa_status_bez
UNION ALL
SELECT 'R' AS qa_status,
 'Verweigerung' AS qa_status_bez
UNION ALL
SELECT 'S' AS qa_status,
 'Annahme' AS qa_status_bez
UNION ALL
SELECT 'Q' AS qa_status,
 'Anfrage' AS qa_status_bez;