/* AW check 2021-05-17*/


UPDATE dbp_data.werbewoche_kl SET
    akt_kjwo_ww_komplett = -1
WHERE akt_kjwo_ww = -1 AND mandant_id IN (8);


UPDATE dbp_data.werbewoche_kl SET
    akt_kjwo_ww_komplett = 0
WHERE akt_kjwo_ww = 1 AND mandant_id IN (
    8) AND dat IN (
    SELECT dat
    FROM dbp_data.tag
    WHERE
        dat = CURRENT_DATE("Europe/Berlin")
        AND wtag_id = 1
);
