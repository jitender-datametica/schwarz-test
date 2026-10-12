/* AW check 2021-05-17*/


UPDATE dbp_data.werbewoche_kl_2 SET
    akt_kjwo_ww_komplett = werbewoche_kl.akt_kjwo_ww
WHERE akt_kjwo_ww <= -1 AND mandant_id IN (4, 1, 3, 5);
