CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_sucessor_stores_gf_prev_1d_1(
	init_store_nr,
	init_store_sid,
	next_store_nr,
	next_store_sid,
	next_store_sid_created_tmsp,
	failed,
	total
)
OPTIONS(DESCRIPTION = 'Sucessor Stores SID current and next with date of changes. Previous Day\nInput datasets\netl_process.t_tcache_lisy_cds_account_snap_1\nmeta.t_party_key_1')
AS WITH RECURSIVE recur AS (SELECT *
   FROM (SELECT repl.accountid,
       repl.igl_number,
       pred.accountid AS prev_account_id,
       pred.igl_number AS prev_igl_number,
       pred.igl_neodate AS prev_open_dt,
       pred.igl_closingdate AS prev_close_dt,
       1 AS level
      FROM ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_1 AS repl
       INNER JOIN ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_1 AS pred ON repl.accountid = pred.igl_replacementid
        
      WHERE repl.accountid IN (SELECT igl_replacementid
         FROM ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_1)
      UNION DISTINCT
      SELECT repl.accountid,
       repl.igl_number,
       pred.accountid AS prev_account_id,
       pred.igl_number AS prev_igl_number,
       pred.igl_neodate AS prev_open_dt,
       pred.igl_closingdate AS prev_close_dt,
       1 AS level
      FROM ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_1 AS repl
       INNER JOIN ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_1 AS pred ON repl.igl_substituteforid =
        pred.accountid
      WHERE repl.igl_substituteforid IN (SELECT accountid
         FROM ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_1))
   UNION ALL
   SELECT repl.accountid,
    repl.igl_number,
    pred.accountid AS prev_account_id,
    pred.igl_number AS prev_igl_number,
    pred.igl_neodate AS prev_open_dt,
    pred.igl_closingdate AS prev_close_dt,
     repl.level + 1 AS level
   FROM recur AS repl
    INNER JOIN ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_1 AS pred ON repl.prev_account_id = pred.igl_replacementid
     ), init_repl_set AS (SELECT igl_number AS descendant_igl_number,
   prev_igl_number AS init_igl_number,
   prev_open_dt,
   prev_close_dt
  FROM recur
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY igl_number ORDER BY level IS NULL DESC, level DESC)) = 1 AND (prev_open_dt
      IS NOT NULL OR prev_close_dt IS NOT NULL)) (SELECT SUBSTR(irs.init_igl_number, 1, 2) || '|' || CAST(ROUND(CAST(SUBSTR(irs.init_igl_number, 3, LENGTH(irs.init_igl_number)) AS BIGNUMERIC), 0) AS STRING)
     AS init_store_nr,
   init_store_key.party_sid AS init_store_sid,
     SUBSTR(irs.descendant_igl_number, 1, 2) || '|' || CAST(ROUND(CAST(SUBSTR(irs.descendant_igl_number, 3, LENGTH(irs.descendant_igl_number)) AS BIGNUMERIC)
      , 0) AS STRING) AS next_store_nr,
   next_store_key.party_sid AS next_store_sid,
   next_store_key.dwh_created_tmsp AS next_store_sid_created_tmsp,
    CASE
    WHEN init_store_key.party_sid <> next_store_key.party_sid
    THEN 1
    ELSE 0
    END AS failed,
   1 AS total
  FROM init_repl_set AS irs
   INNER JOIN ldl_data_production_meta.t_party_key_1 AS init_store_key ON SUBSTR(irs.init_igl_number, 1, 2) || '|' || CAST(ROUND(CAST(SUBSTR(irs.init_igl_number, 3, LENGTH(irs.init_igl_number)) AS BIGNUMERIC)
        , 0) AS STRING) = init_store_key.party_nat_key_nr AND init_store_key.party_key_type_cd = 'STORE'
   INNER JOIN ldl_data_production_meta.t_party_key_1 AS next_store_key ON SUBSTR(irs.descendant_igl_number, 1, 2) || '|'
      || CAST(ROUND(CAST(SUBSTR(irs.descendant_igl_number, 3, LENGTH(irs.descendant_igl_number)) AS BIGNUMERIC), 0) AS
       STRING) = next_store_key.party_nat_key_nr AND next_store_key.party_key_type_cd = 'STORE'
  WHERE next_store_key.dwh_created_tmsp >= CAST(date_sub(current_date(), interval 1 DAY) AS TIMESTAMP)
    );