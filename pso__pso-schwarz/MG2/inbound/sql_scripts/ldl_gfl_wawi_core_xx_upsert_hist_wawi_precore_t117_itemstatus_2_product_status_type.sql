INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        prod_status_categ_cd,
        prod_status_type_cd,
        lang_cd,
        prod_status_type_descr,
        dwh_created_tmsp,
        dwh_updated_tmsp,
        -- framework and technical columns
        source_system,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
SELECT  prod_status_categ_cd
        ,src.status AS prod_status_type_cd
        ,src.official_lang_cd AS lang_cd
        ,src.statusdesc AS prod_status_type_descr
        ,CURRENT_TIMESTAMP AS dwh_created_tmsp
        ,CURRENT_TIMESTAMP AS dwh_updated_tmsp
        ,'WAWI' AS source_system
        ,CURRENT_DATE AS extraction_dt
        ,CURRENT_TIMESTAMP AS dwh_mapping_tmsp
        ,0 AS tf_error_fg
        ,0 AS deleted_fg
        ,0 AS record_id
        ,'t_wawi_precore_t117_itemstatus' AS filename
        ,'WAWI' AS dwh_node_cd
        ,'${LOAD_ID}'  as dwh_load_id
  FROM
    ( SELECT
          'WAWI_HQ_LIFECYCLE' AS prod_status_categ_cd
          ,status
          ,ANY_VALUE(TRIM(statusdesc)) AS statusdesc
          ,official_lang_cd
      FROM etl.t_wawi_precore_t118_statusdesc t118
      JOIN
            core_rel.t_country as ctr
        ON  ctr.iso_country_cd = t118.ctrcode AND dwh_valid_fg
      WHERE hq=1 AND official_lang_cd IS NOT NULL 
      GROUP BY
          status
          ,official_lang_cd
      UNION
      SELECT
          'WAWI_WH_LIFECYCLE' AS prod_status_categ_cd
          ,status
          ,ANY_VALUE(TRIM(statusdesc)) AS statusdesc
          ,official_lang_cd
      FROM etl.t_wawi_precore_t118_statusdesc t118
      JOIN
            core_rel.t_country as ctr
        ON  ctr.iso_country_cd = t118.ctrcode AND dwh_valid_fg        
      WHERE wh=1 AND official_lang_cd IS NOT NULL 
      GROUP BY
          status
          ,official_lang_cd

    ) AS src
WHERE src.status IS NOT NULL
  AND src.official_lang_cd IS NOT NULL
  AND src.statusdesc IS NOT NULL
;                        
