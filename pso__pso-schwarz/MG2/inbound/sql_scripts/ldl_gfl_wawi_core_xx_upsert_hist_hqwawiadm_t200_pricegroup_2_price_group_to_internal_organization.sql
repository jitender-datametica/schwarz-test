INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
    int_org_key_type_cd,
    party_nat_key_nr,
    price_grp_key_type_cd,
    price_grp_nat_key_nr,

    int_org_type_cd,
    price_grp_prio,

    dwh_ending_tmsp,
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
SELECT DISTINCT
    CASE WHEN c200_storenr = 0 THEN 'COUNTRY'
         WHEN c200_storenr = c200_warehouse THEN 'COMPANY'
         ELSE 'STORE'
    END AS int_org_key_type_cd,
    CASE WHEN c200_storenr = 0 THEN LEFT(pg.wawi_instanz_kzl,2)
         WHEN c200_storenr = c200_warehouse THEN LEFT(pg.wawi_instanz_kzl,2) || '|' ||  CAST(pg.c200_warehouse AS INTEGER)
         ELSE LEFT(pg.wawi_instanz_kzl,2) || '|' ||  CAST(pg.c200_storenr AS INTEGER)
    END AS party_nat_key_nr,
    'WAWI' AS price_grp_key_type_cd,
    LEFT(pg.wawi_instanz_kzl,2)  || '|' ||  CAST(pg.c200_groupnr AS INTEGER) AS price_grp_nat_key_nr,

    CASE WHEN c200_storenr = 0 OR c200_storenr = c200_warehouse THEN 'COMPANY'
         ELSE 'STORE'
    END AS int_org_type_cd,
    c200_priority AS price_grp_prio,

    c200_dateto AS dwh_ending_tmsp,
    'WAWI' AS source_system,
    DATE_TRUNC('day',extraction_tmsp) AS extraction_dt,
    c200_datefrom AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'WAWI' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t200_pricegroup pg
LEFT OUTER JOIN meta.t_resource_item_key AS rk
    ON party_nat_key_nr = rk.resource_item_nat_key_nr
    AND rk.dwh_valid_fg
LEFT OUTER JOIN core_rel.t_real_estate AS rer
    ON rk.resource_item_sid = rer.real_estate_sid
   AND rer.dwh_valid_fg
WHERE c200_lastedited >= '${SRC_START_DATE}'
      AND
        pg.c200_datefrom
           BETWEEN CASE WHEN c200_storenr = 0 OR c200_storenr = c200_warehouse THEN DATE'1900-01-01'
                        ELSE rer.open_dt
                   END
           AND
           COALESCE( rer.close_dt, DATE'9999-12-31')

QUALIFY ROW_NUMBER() OVER (PARTITION BY party_nat_key_nr, price_grp_nat_key_nr, dwh_mapping_tmsp ORDER BY dwh_ending_tmsp DESC) = 1
;
