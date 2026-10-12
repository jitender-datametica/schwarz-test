/*
USER STORY 489224
*/


UPDATE dbp_data.wupcal_2 SET
    offen = 0,
    td_update = CURRENT_TIMESTAMP()
WHERE
    dat > DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY)
    AND offen = 1
    AND (mandant_id, wup_id, dat) IN (SELECT (
        mandant_id,
        wup_id, dat
    )
    FROM dbp_data.wupcal_ereignis_zu_2
    WHERE offen = 0) AND COALESCE(bonanzahl_sug, 0) = 0;
