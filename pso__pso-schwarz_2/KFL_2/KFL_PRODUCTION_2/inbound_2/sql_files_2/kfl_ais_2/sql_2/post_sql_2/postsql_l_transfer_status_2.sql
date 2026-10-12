INSERT INTO DBP_DATA.TRANSFER_STATUS_SPR_ZU_2
SELECT a.mandant_id, 22, a.transfer_status_id, 'keine Information verfügbar', current_timestamp(), current_timestamp()
FROM DBP_DATA.L_TRANSFER_STATUS_2 a
LEFT JOIN DBP_DATA.TRANSFER_STATUS_SPR_ZU_2 b
ON a.mandant_id = b.mandant_id
AND a.transfer_status_id = b.transfer_status_id
WHERE b.mandant_id IS NULL;
