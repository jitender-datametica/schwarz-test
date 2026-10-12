UPDATE dbp_data.wupcal SET
    offen = dt1.offen,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        MAX(offen) AS offen
    FROM dbp_data.wupcal_ereignis_zu AS WEZ
    GROUP BY
        dat,
        wup_id,
        nb_id,
        mandant_id
) AS dt1
WHERE
    dt1.mandant_id = wupcal.mandant_id
    AND dt1.wup_id = wupcal.wup_id
    AND dt1.nb_id = wupcal.nb_id
    AND dt1.dat
    = wupcal.dat AND dt1.dat = CURRENT_DATE("Europe/Berlin");


UPDATE dbp_data.wupcal SET
    datenlieferung_bonanzahl = 4,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_data.wupcal AS WEZ
    WHERE
        mandant_id = 1
        AND nb_id = 2
        AND offen = 1
        AND dat = CURRENT_DATE("Europe/Berlin")
) AS dt1
WHERE
    dt1.mandant_id = wupcal.mandant_id
    AND dt1.wup_id = wupcal.wup_id
    AND dt1.nb_id = wupcal.nb_id
    AND dt1.dat
    = wupcal.dat;
