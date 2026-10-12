/* AW check 2021-05-17*/


UPDATE dbp_data.werbewoche_kl SET
    akt_kjwo_ww_komplett = werbewoche_kl.akt_kjwo_ww + 1
WHERE akt_kjwo_ww <= -1 AND mandant_id IN (4, 1, 3, 5);


UPDATE dbp_data.werbewoche_kl SET
    akt_kjwo_ww_komplett = 0
WHERE akt_kjwo_ww = 1 AND mandant_id IN (
    4, 1, 3, 5) AND dat IN (
    SELECT dat
    FROM dbp_data.tag
    WHERE
        dat = DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 DAY)
        AND wtag_id = 4
        OR dat = DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 2 DAY)
        AND wtag_id = 4
        OR dat = DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        AND wtag_id = 4
        OR dat = CURRENT_DATE("Europe/Berlin") AND wtag_id = 4
);
