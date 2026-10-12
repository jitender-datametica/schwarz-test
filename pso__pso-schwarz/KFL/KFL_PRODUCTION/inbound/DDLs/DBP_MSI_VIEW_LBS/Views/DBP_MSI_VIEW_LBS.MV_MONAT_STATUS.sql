CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_MONAT_STATUS(
	STATUS_ID,
	STATUS_BEZ
) AS SELECT 
    status_id,
    status_bez
    FROM (VALUES 
    (1, 'abgeschlossene Monate'), 
    (0, 'nicht abgeschlossene Monate') AS t1(status_id, status_bez)
    );