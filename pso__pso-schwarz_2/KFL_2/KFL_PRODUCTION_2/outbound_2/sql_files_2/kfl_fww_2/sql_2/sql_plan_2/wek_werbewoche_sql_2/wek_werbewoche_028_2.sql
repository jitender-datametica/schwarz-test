UPDATE dbp_data.werbewoche_kl_2 SET
    angepasste_kjwo_ww = werbewoche_kl.kjwo_ww
WHERE mandant_id = 1;


UPDATE dbp_data.werbewoche_kl_2 SET
    angepasste_kjwo_ww = b.kjwo_ww
FROM dbp_etl_process.werbewoche_real_manuell_2 AS b
WHERE werbewoche_kl.mandant_id = b.mandant_id AND werbewoche_kl.dat = b.dat;
