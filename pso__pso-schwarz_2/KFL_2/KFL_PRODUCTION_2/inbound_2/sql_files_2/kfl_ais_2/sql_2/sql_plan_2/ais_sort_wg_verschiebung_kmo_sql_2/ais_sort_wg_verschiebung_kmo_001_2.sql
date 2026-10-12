--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_ETL.art_matching_nielsen_per_kmo_2 SET kl_owg_id = b.wg_id_neu,
    kl_uwg_id = b.wug_id_neu
	
FROM (SELECT mandant_id,
                                                                        art_nielsen_id,
                                                                        CASE WHEN wg_id  = -1 THEN wg_id_vorschl  ELSE wg_id  END AS wg_id_neu,
                                                                        CASE WHEN wug_id = -1 THEN wug_id_vorschl ELSE wug_id END AS wug_id_neu
                                                                 FROM DBP_DATA.art_nielsen_wug_zu_pflege_2
                                                                 WHERE mandant_id > 1) b

WHERE DBP_ETL.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
      DBP_ETL.art_matching_nielsen_per_kmo.art_nielsen_id = b.art_nielsen_id AND
      DBP_ETL.art_matching_nielsen_per_kmo.art_id = -1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_ETL.art_matching_nielsen_per_kmo_2 SET kl_wg_id = b.owg_id
	
FROM (SELECT *
                                                                 FROM DBP_DATA.wg_per_2
                                                                 WHERE dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
                                                                       owg_id <> -1) b

WHERE DBP_ETL.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
      DBP_ETL.art_matching_nielsen_per_kmo.kl_owg_id = b.wg_id
;

