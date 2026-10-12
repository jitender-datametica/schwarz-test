CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_PIT_VERSION_INFO
AS
   SELECT
     version_dt,
   dwh_valid_from,
   dwh_valid_to,
   major_number,
   minor_number,
   build_number,
   revision_number,
   version_info_descr,
   version_info_descr
    || ' ['
    || LPAD(CAST(major_number AS VARCHAR(12)), 2, '0')
    || '.'
    || LPAD(CAST(minor_number AS VARCHAR(12)), 3, '0')
    || '.'
    || LPAD(CAST(build_number AS VARCHAR(12)), 2, '0')
    || '.'
    || LPAD(CAST(revision_number AS VARCHAR(12)), 2, '0') || '] - '
   || CAST(version_dt /*Warning, Format 'YYYY-MMM-DD' removed, semantic information not found.*/ AS VARCHAR(20))
   AS version_info_descr_long,
   LPAD(CAST(major_number AS VARCHAR(12)), 2, '0')
    || '.'
    || LPAD(CAST(minor_number AS VARCHAR(12)), 3, '0')
    || '.'
    || LPAD(CAST(build_number AS VARCHAR(12)), 2, '0')
    || '.'
    || LPAD(CAST(revision_number AS VARCHAR(12)), 2, '0')
    AS version_number_descr


  FROM p_lew_mart_analytics.t_pit_version_info
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  QUALIFY ROW_NUMBER() OVER (ORDER BY dwh_valid_to DESC NULLS LAST, version_dt DESC NULLS LAST, version_number_descr DESC NULLS LAST) = 1;