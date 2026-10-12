CREATE OR REPLACE materialized VIEW DBP_MSI_VIEW_LOG.MV_L_QUEUE_PROMPT_1(
	QUEUE_ID
) AS
--2023-11-23, dknop, initial
SELECT queue_id FROM dbp_data.lageraufgabe_1 GROUP BY 1;