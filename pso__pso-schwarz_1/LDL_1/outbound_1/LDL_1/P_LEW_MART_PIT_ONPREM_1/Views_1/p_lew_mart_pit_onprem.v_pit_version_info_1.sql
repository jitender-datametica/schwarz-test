CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_version_info_1 AS SELECT version_dt,
 dwh_valid_from,
 dwh_valid_to,
 major_number,
 minor_number,
 build_number,
 revision_number,
 version_info_descr,
           version_info_descr || ' [' || LPAD(CAST(major_number AS STRING), 2, '0') || '.' || LPAD(CAST(minor_number AS STRING)
         , 3, '0') || '.' || LPAD(CAST(build_number AS STRING), 2, '0') || '.' || LPAD(CAST(revision_number AS STRING),
     2, '0') || '] - ' || CAST(version_dt AS STRING FORMAT 'YYYY-MON-DD') AS version_info_descr_long,
       LPAD(CAST(major_number AS STRING), 2, '0') || '.' || LPAD(CAST(minor_number AS STRING), 3, '0') || '.' || LPAD(CAST(build_number AS STRING)
     , 2, '0') || '.' || LPAD(CAST(revision_number AS STRING), 2, '0') AS version_number_descr
FROM ldl_p_lew_mart_pit_onprem.t_pit_version_info_1
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
QUALIFY (ROW_NUMBER() OVER (ORDER BY dwh_valid_to IS NULL, dwh_valid_to, version_dt IS NULL, version_dt, (LPAD(CAST(major_number AS STRING)
              , 2, '0') || '.' || LPAD(CAST(minor_number AS STRING), 3, '0') || '.' || LPAD(CAST(build_number AS STRING)
           , 2, '0') || '.' || LPAD(CAST(revision_number AS STRING), 2, '0')) IS NULL, LPAD(CAST(major_number AS STRING)
             , 2, '0') || '.' || LPAD(CAST(minor_number AS STRING), 3, '0') || '.' || LPAD(CAST(build_number AS STRING)
          , 2, '0') || '.' || LPAD(CAST(revision_number AS STRING), 2, '0'))) = 1;