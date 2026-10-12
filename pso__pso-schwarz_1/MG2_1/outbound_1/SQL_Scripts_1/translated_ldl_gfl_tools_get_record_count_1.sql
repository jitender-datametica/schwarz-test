
BEGIN
  DECLARE UpdtSTMT STRING;
  DECLARE OUTPUT STRING DEFAULT 'SUCCESS';

  BEGIN
  
    FOR rec IN (
      SELECT
        table_schema,
        table_name
      FROM `dm-eagle.region_1-us.INFORMATION_SCHEMA.TABLES`
      WHERE table_schema IN ('ldl_data_production_meta', 'ldl_data_production_core_rel', 'ldl_data_production_core_dim', 'ldl_data_production_core_app_fraud_detection')
        AND table_name NOT LIKE 'v%'
        AND table_name NOT LIKE 't_dv_%'
        AND table_name NOT LIKE '%backup%'
        AND table_name NOT LIKE 't_tf_%'
        AND table_name NOT LIKE 't_ts_%'
        AND table_name NOT LIKE '%test_1%'
      ORDER BY table_schema, table_name
    )
    DO
      SET UpdtSTMT = '''
        MERGE `ldl_data_production_etl.t_rec_cnt_1` t
        using (
          select
            '''||rec.table_schema||'.'||rec.table_name||'''  as tbl_name,
            current_date() as bus_dt,
            count(1) as cnt
          from '''||rec.table_schema||'.'||rec.table_name||''' 
        ) s
        on t.tbl_name = s.tbl_name
       and t.bus_dt = s.bus_dt
        when matched then
          update set
            tbl_rec_cnt = s.cnt,
            dwh_updated_tmsp = current_timestamp()
        when not matched then
          insert (bus_dt, tbl_name, tbl_rec_cnt, dwh_created_tmsp, dwh_updated_tmsp)
          values (s.bus_dt, s.tbl_name, s.cnt, current_timestamp(), current_timestamp())
      ''';

      EXECUTE IMMEDIATE UpdtSTMT;
    END FOR;

  EXCEPTION WHEN ERROR THEN
    SET OUTPUT = @@error.message;
  END;


  SELECT OUTPUT AS result;

END;

