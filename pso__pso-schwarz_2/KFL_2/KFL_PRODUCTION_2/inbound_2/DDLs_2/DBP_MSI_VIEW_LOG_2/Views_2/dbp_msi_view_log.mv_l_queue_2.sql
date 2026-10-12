CREATE OR REPLACE materialized VIEW DBP_MSI_VIEW_LOG.MV_L_QUEUE_2(
	MANDANT_ID,
	LAGERNUMMER_ID,
	QUEUE_ID
) AS
--2023-11-23, dknop, initial
SELECT mandant_id, lagernummer_id, queue_id FROM dbp_data.lageraufgabe_2 GROUP BY 1,2,3;