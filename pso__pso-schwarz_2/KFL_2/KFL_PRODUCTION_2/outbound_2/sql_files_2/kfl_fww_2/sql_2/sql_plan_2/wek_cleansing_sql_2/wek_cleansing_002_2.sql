TRUNCATE TABLE dbp_etl_process.ekc_artbew_agg_wt_2;


UPDATE dbp_etl_process.fww_gld_zeitraum_2 SET
    akt_mo = -2
WHERE TRUE;
