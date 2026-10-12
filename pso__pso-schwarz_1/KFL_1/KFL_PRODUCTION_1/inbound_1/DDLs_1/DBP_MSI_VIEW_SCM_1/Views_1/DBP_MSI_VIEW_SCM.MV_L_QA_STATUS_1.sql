CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_QA_STATUS_1(
	QA_STATUS,
	QA_STATUS_BEZ
)AS
--2025-03-06,AP0205147, dknop, initial
SELECT
 'A' AS qa_status
,'Konzession' AS qa_status_bez
UNION
SELECT
 'R' AS qa_status
,'Verweigerung' AS qa_status_bez
UNION
SELECT
 'S' AS qa_status
,'Annahme' AS qa_status_bez
UNION
SELECT
 'Q' AS qa_status
,'Anfrage' AS qa_status_bez
;