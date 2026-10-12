--[OK] statement is translated correctly (syntax and type checks are fine)
--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.POSLOG_AGG_WT_2' does not exist or not authorized.
DELETE FROM DBP_ETL_PROCESS.poslog_agg_wt_2
WHERE mandant_id > 1;

