CREATE TABLE p_lew_process.t_log_uap2wfm_2
     (
      proj_name VARCHAR(10) NOT NULL COLLATE 'en-ci',
      hive_table_name VARCHAR(50) NOT NULL COLLATE 'en-ci',
      date_partkey DATE NOT NULL,
      daily_run_counter INTEGER NOT NULL,
      last_upd_timestamp TIMESTAMP(6) NOT NULL,
      uap_cluster VARCHAR(2) COLLATE 'en-ci' NOT NULL,
      wfm_env_name VARCHAR(4) COLLATE 'en-ci' NOT NULL,
UNIQUE  ( proj_name ,hive_table_name ,date_partkey , daily_run_counter ,wfm_env_name)
     );