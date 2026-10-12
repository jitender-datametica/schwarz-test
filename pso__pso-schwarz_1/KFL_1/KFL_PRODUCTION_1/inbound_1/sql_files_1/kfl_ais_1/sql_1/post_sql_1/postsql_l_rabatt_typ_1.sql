INSERT INTO DBP_DATA.RABATT_TYP_SPR_ZU_1
SELECT a.mandant_id, 22, a.rabatt_typ_id, 'keine Information verfügbar', current_timestamp(), current_timestamp()
FROM DBP_DATA.L_RABATT_TYP_1 a
LEFT JOIN DBP_DATA.RABATT_TYP_SPR_ZU_1 b
ON a.mandant_id = b.mandant_id
AND a.rabatt_typ_id = b.rabatt_typ_id
WHERE b.mandant_id IS NULL;
