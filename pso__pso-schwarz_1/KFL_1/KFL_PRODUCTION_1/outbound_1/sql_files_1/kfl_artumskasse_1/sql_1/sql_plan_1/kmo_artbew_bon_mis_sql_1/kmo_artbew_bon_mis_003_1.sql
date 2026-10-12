--[OK] statement is translated correctly (syntax and type checks are fine)
--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.POSLOG_AGG_WT_1' does not exist or not authorized.


DELETE FROM dbp_etl_process.poslog_agg_wt_1
WHERE mandant_id > 1;
