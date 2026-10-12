UPDATE dbp_data.werbewoche_kl_1 SET
    akt_kjwo_ww_komplett = -1
WHERE akt_kjwo_ww = -1 AND mandant_id IN (7, 2, 6);
