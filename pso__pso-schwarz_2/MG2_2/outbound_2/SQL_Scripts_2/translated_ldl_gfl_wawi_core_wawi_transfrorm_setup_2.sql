

DECLARE output STRING DEFAULT 'SUCCESS';
DECLARE src_tables ARRAY<STRING>;

BEGIN

  EXECUTE IMMEDIATE """
  merge `ldl_data_production_etl.wawi_control_table_hist_2` t
  using (
    select
      (select coalesce(max(load_id), 0) + 1 from `ldl_data_production_etl.wawi_control_table_hist_2`) as load_id,
      source_table_name,
      begin_tmsp,
      end_tmsp,
      rec_count,
      source_status,
      updated_tmsp
    from `ldl_data_production_etl.wawi_control_table_2`
  ) s
  on t.source_table_name = s.source_table_name
 and t.begin_tmsp = s.begin_tmsp
 and t.created_tmsp = s.updated_tmsp
  when not matched then
    insert (
      load_id,
      source_table_name,
      begin_tmsp,
      end_tmsp,
      rec_count,
      source_status,
      created_tmsp
    )
    values (
      s.load_id,
      s.source_table_name,
      s.begin_tmsp,
      s.end_tmsp,
      s.rec_count,
      s.source_status,
      s.updated_tmsp
    )
  """;

  SET src_tables = (
    SELECT ARRAY_AGG(SOURCE_TABLE_NAME)
    FROM `ldl_data_production_etl.wawi_control_table_2`
  );


  FOR tbl IN (SELECT * FROM UNNEST(src_tables)) DO
  BEGIN
    EXECUTE IMMEDIATE (
      '''
      MERGE `ldl_data_production_etl.wawi_control_table_2` t
      using (
        select
          flt.source_table_name as src_name,
          min(src.extraction_tmsp) as b_tmsp,
          max(src.extraction_tmsp) as e_tmsp,
          count(1) as cnt
        from `''' || tbl || '''` src
        join `ldl_data_production_etl.wawi_control_table_2` flt
          on flt.source_table_name = ''' || tbl || '''
         and src.extraction_tmsp > flt.end_tmsp
         and flt.source_status = 'A'
        group by src_name
        having b_tmsp <> e_tmsp
      ) s
      on t.source_table_name = s.src_name
      when matched then
        update set
          begin_tmsp   = s.b_tmsp,
          end_tmsp     = s.e_tmsp,
          rec_count    = s.cnt,
          updated_tmsp = current_timestamp()
      '''
    );
  EXCEPTION WHEN ERROR THEN
    CONTINUE;
  END;
END FOR;


EXCEPTION WHEN ERROR THEN
  SET output = @@error.message;
END;


SELECT output AS status_2;
