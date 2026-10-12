CREATE OR REPLACE VIEW ETL_PROCESS.V_LC_PRTCL_DELETE_TASKS_1
AS
SELECT deltasks.tcache_database AS tcache_database
      ,deltasks.tcache_tablename AS tcache_tablename
      ,deltasks.tcache_processcontainer AS tcache_processcontainer
      ,deltasks.context_area_type AS context_area_type
      ,deltasks.context_area AS context_area
      ,deltasks.context_load_id AS context_load_id
      ,deltasks._cnt_wait4pending AS cnt_wait4pending
      ,deltasks._last_touched_ts AS last_touched_ts
      ,deltasks.days_after_last_touch AS days_after_last_touch
      ,deltasks.tcache_deleted_since AS tcache_deleted_since
      ,static_ctx_resolve.country_codes AS country_codes
FROM
    (SELECT DISTINCT 
            UPPER(tcache_database) tcache_database
            ,LOWER(tcache_tablename) tcache_tablename
            ,tcache_processcontainer
            ,context_area_type
            ,context_area
            ,context_load_id
            ,CASE WHEN ctx_state='ready' THEN cnt_wait4pending
                 ELSE MAX(cnt_wait4pending) OVER (PARTITION BY context_area_type
                                                               ,context_area
                                                               ,context_load_id)
            END _cnt_wait4pending
            ,CASE WHEN ctx_state='ready' THEN
                    MAX(last_touched_ts) OVER (PARTITION BY tcache_database
                                                     ,tcache_tablename
                                                     ,tcache_processcontainer
                                                     ,context_area_type
                                                     ,context_area
                                                     ,context_load_id)
                ELSE MAX(last_touched_ts) OVER (PARTITION BY context_area_type
                                                   ,context_area
                                                   ,context_load_id)
            END _last_touched_ts
            ,FLOOR(TIMESTAMPDIFF(SECOND,_last_touched_ts,CURRENT_TIMESTAMP)/86400) days_after_last_touch
            ,MAX(tcache_deleted_since) OVER (PARTITION BY tcache_database
                                                     ,tcache_tablename
                                                     ,tcache_processcontainer
                                                     ,context_area_type
                                                     ,context_area
                                                     ,context_load_id) tcache_deleted_since
    FROM ETL_PROCESS.v_lc_prtcl_new_process_runstate_1
    ) deltasks
INNER JOIN
    ( 
     --alle denkbaren statischen Kontexte mit Aufloesung in Country_1-Codes als KommASeparierte Liste enclosed BY
      SELECT LISTAGG(TRIM(country_cd), ',') WITHIN GROUP (ORDER BY country_cd) country_codes 
              ,area_grp_type
              ,area_cd
       FROM (
       --alle denkbaren statischen Kontexte
            SELECT DISTINCT client_id
                   ,''''||country_cd||'''' country_cd
                    ,area_grp_type
                    ,area_cd
            FROM ETL_PROCESS.v_etl_context_orga_area_1
            ) base
       GROUP BY area_grp_type,area_cd
     ) static_ctx_resolve
ON static_ctx_resolve.area_grp_type    =   deltasks.context_area_type
AND static_ctx_resolve.area_cd         =   deltasks.context_area
WHERE deltasks.tcache_deleted_since IS NULL
AND UPPER(deltasks.tcache_tablename)<>'NONE'
;