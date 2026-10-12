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
        ,src.status_2 AS prod_status_type_cd
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
        ,'t_wawi_precore_t117_itemstatus_2' AS filename
        ,'WAWI' AS dwh_node_cd
        ,'${LOAD_ID}'  as dwh_load_id
  FROM
    ( SELECT
          'WAWI_HQ_LIFECYCLE' AS prod_status_categ_cd
          ,c118_status AS status_2
          ,ANY_VALUE(TRIM(c118_statusdesc)) AS statusdesc
          ,official_lang_cd
      FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t118_statusdesc_2 t118
      JOIN
            core_rel.t_country_2 as ctr
        ON  ctr.iso_country_cd = LEFT(t118.wawi_instanz_kzl,2) AND dwh_valid_fg
      WHERE c118_hq=1 AND official_lang_cd IS NOT NULL AND t118.delete_fg IS NULL
      GROUP BY
          status_2
          ,official_lang_cd
      UNION
      SELECT
          'WAWI_WH_LIFECYCLE' AS prod_status_categ_cd
          ,c118_status AS status_2
          ,ANY_VALUE(TRIM(c118_statusdesc)) AS statusdesc
          ,official_lang_cd
      FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t118_statusdesc_2 t118
      JOIN
            core_rel.t_country_2 as ctr
        ON  ctr.iso_country_cd = LEFT(t118.wawi_instanz_kzl,2) AND dwh_valid_fg        
      WHERE c118_wh=1 AND official_lang_cd IS NOT NULL AND t118.delete_fg IS NULL
      GROUP BY
          status_2
          ,official_lang_cd

    ) AS src
WHERE src.status_2 IS NOT NULL
  AND src.official_lang_cd IS NOT NULL
  AND src.statusdesc IS NOT NULL
;                        
