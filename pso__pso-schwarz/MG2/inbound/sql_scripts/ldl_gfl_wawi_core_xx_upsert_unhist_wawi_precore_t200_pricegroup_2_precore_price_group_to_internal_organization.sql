DELETE FROM ETL.T_PRECORE_PRICE_GROUP_TO_INTERNAL_ORGANIZATION;

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
    int_org_key_type_cd,	
    party_nat_key_nr,
    price_grp_key_type_cd,	
    price_grp_nat_key_nr,
    
    int_org_type_cd,
    price_grp_prio,
    datefrom, 
    dateto,
    open_dt,
    close_dt,
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
       case when C200_WAREHOUSE = 0 and C200_STORENR = 0 then 'COUNTRY'
            when C200_STORENR = 0 then 'COMPANY'
            else 'STORE' 
        end AS int_org_key_type_cd,
      case when C200_WAREHOUSE = 0 and C200_STORENR = 0 then pg.ctrcode
            when C200_STORENR = 0 then pg.ctrcode || '|' ||  CAST(pg.C200_WAREHOUSE AS INTEGER)
            else pg.ctrcode || '|' ||  CAST(pg.C200_STORENR AS INTEGER)
        end AS party_nat_key_nr,
       'WAWI' AS price_grp_key_type_cd,    
       pg.ctrcode || '|' ||  CAST(pg.c200_groupnr AS INTEGER) AS price_grp_nat_key_nr, 
    
       --'STORE' AS int_org_type_cd,
       int_org_key_type_cd AS int_org_type_cd,
       pg.c200_priority AS price_grp_prio,  
       pg.c200_datefrom,
       pg.c200_dateto,        
       case when C200_WAREHOUSE = 0 and C200_STORENR = 0 then to_date( '1900-01-01')
            when C200_STORENR = 0 then to_date( '1900-01-01')
            else rer.open_dt
        end as open_dt,
       COALESCE( rer.close_dt, '9999-12-31') as close_dt, 
       'WAWI' AS source_system,       
       DATE_TRUNC('day', pg.extraction_tmsp) AS extraction_dt,
       Current_timestamp AS dwh_mapping_tmsp,    
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       't_${SRC_INPUT_TABLE}' AS filename,
       'WAWI' AS dwh_node_cd,
       '${LOAD_ID}' AS dwh_load_id 
  FROM etl.t_wawi_precore_t200_pricegroup pg
  left join meta.t_resource_item_key as rk
    on PARTY_NAT_KEY_NR = rk.resource_item_nat_key_nr
   and rk.DWH_VALID_FG
  left join core_rel.t_real_estate as rer
    on rk.RESOURCE_ITEM_SID = rer.REAL_ESTATE_SID    
   and rer.DWH_VALID_FG 
;
