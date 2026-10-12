UPDATE dbp_data.werbewoche_kl_1 SET
    akt_kjwo_ww_komplett = werbewoche_kl.akt_kjwo_ww + 1
WHERE akt_kjwo_ww <= -1 AND mandant_id IN (7, 2, 6);


UPDATE dbp_data.werbewoche_kl_1 SET
    akt_kjwo_ww_komplett = 0
WHERE akt_kjwo_ww = 1 AND mandant_id IN (
    7, 2, 6) AND dat IN (
    SELECT dat
    FROM dbp_data.tag_1
    WHERE
        dat = DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 2 DAY)
        AND wtag_id = 3
        OR dat = DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        AND wtag_id = 3
        OR dat = CURRENT_DATE("Europe/Berlin") AND wtag_id = 3
);
