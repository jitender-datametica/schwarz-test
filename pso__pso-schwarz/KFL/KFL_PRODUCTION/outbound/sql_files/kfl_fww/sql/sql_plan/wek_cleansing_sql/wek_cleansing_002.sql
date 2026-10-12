TRUNCATE TABLE dbp_etl_process.ekc_artbew_agg_wt;


UPDATE dbp_etl_process.fww_gld_zeitraum SET
    akt_mo = -2
WHERE TRUE;
