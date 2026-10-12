INSERT INTO DBP_DATA.ANGEBOT_STATUS_SPR_ZU_2
SELECT a.mandant_id, 22, a.angebot_status_id, 'keine Information verfügbar', current_timestamp(), current_timestamp()
FROM DBP_DATA.L_ANGEBOT_STATUS_2 a
LEFT JOIN DBP_DATA.ANGEBOT_STATUS_SPR_ZU_2 b
ON a.mandant_id = b.mandant_id
AND a.angebot_status_id = b.angebot_status_id
WHERE b.mandant_id IS NULL;
