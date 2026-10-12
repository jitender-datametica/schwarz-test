TRUNCATE TABLE dbp_etl_process.ekc_artbew_agg_wt_1;


UPDATE dbp_etl_process.fww_gld_zeitraum_1 SET
    akt_mo = -2
WHERE TRUE;
