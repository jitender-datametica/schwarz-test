
DELETE FROM  core_dim.t_dim_real_estate_2;

-- Dummy_2 row
insert into core_dim.t_dim_real_estate_2 
(
    REAL_ESTATE_SID
	,DWH_VALID_FROM_TMSP
	,DWH_VALID_TO_TMSP
	,DWH_VALID_FG
	
	,REAL_ESTATE_NR
	,REAL_ESTATE_NAME
	,REAL_ESTATE_TYPE_CD
	,REAL_ESTATE_TYPE_DESCR
	,REAL_ESTATE_STATUS_CD
	,REAL_ESTATE_STATUS_DESCR
	
	,INT_ORG_SID
	,CURR_INT_ORG_NR
	,INT_ORG_NAME
	,INT_ORG_TYPE_CD
	,INT_ORG_TYPE_DESCR
	
	,OWNERSHIP_TYPE_CD
	,OWNERSHIP_TYPE_DESCR
	,OWNERSHIP_RATIO_TYPE_CD
	,OWNERSHIP_RATIO_TYPE_DESCR
	,OWN_ACQUISITION_FG
	
	,REAL_ESTATE_USG_TYPE_CD
	,REAL_ESTATE_USG_TYPE_DESCR
	,REPLACEMENT_REAL_ESTATE_SID
	,REPLACEMENT_REAL_ESTATE_NR
	,REPLACEMENT_REAL_ESTATE_NAME
	,REAL_ESTATE_REPLACEMENT_TYPE_CD
	,REAL_ESTATE_REPLACEMENT_TYPE_DESCR
	
	,WH_BUILDING_TYPE_CD
	,WH_BUILDING_TYPE_DESCR
	,WH_PURPOSE_CD
	,WH_PURPOSE_DESCR
	,SHARED_USG_FG
	
	,ISO_COUNTRY_CD
	,COUNTRY_NAME
	,CITY_NAME
	,DISTRICT_NAME
	,ZIP
	,STREET_NAME
	,HOUSE_NR
	,LON
	,LAT
	,PO_BOX_NR
	,PHONE_NR
	,FAX_NR
	,EMAIL_ADDR_TXT
	,REPORTING_COUNTRY_CD
	,REPORTING_COUNTRY_NAME
	
	,SALES_AREA_MEAS
	,STORAGE_AREA_MEAS
	,TOTAL_SUBLET_AREA_MEAS
	,RENTED_SUBLET_AREA_MEAS
	,UOM_CD
	,SALES_AREA_M2_MEAS
	,STORAGE_AREA_M2_MEAS
	,TOTAL_SUBLET_AREA_M2_MEAS
	,RENTED_SUBLET_AREA_M2_MEAS
	,TOTAL_PARKING_SPACE_CNT
	,OWN_PARKING_SPACE_CNT
	,UNDERGROUND_PARKING_SPACE_CNT
	,RENTAL_COST_VAL
	,RENTAL_INCOME_VAL
	,CURR_CD
	,RENTAL_COST_EUR_VAL
	,RENTAL_INCOME_EUR_VAL
	
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_LOAD_ID
	,DWH_NODE_CD
)
VALUES 
(
	-1,
    to_timestamp('1900-01-01'),
    to_timestamp('9999-12-31 23:59:59.999999999'),
    true,
	
	null,
	'Unbekannt',
	'@',
	'Unbekannt',
	'@',
	'Unbekannt',
	
	-1,
	'@',
	'Unbekannt',
	'@',
	'Unbekannt',
	
	'@',
	'Unbekannt',
	'@',
	'Unbekannt',
	false,
	
	'@',
	'Unbekannt',
	-1,
	null,
	'Unbekannt',
	'@',
	'Unbekannt',
	
	'@',
	'Unbekannt',
	'@',
	'Unbekannt',
	false,
	
	'@',
    'Unbekannt',
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
	'@',
	'Unbekannt',
	
	null,
	null,
	null,
	null,
	'@',
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	'@',
	null,
	null,
	
	current_timestamp,
    current_timestamp,
    -1,
    'MANUAL'
);


insert into core_dim.t_dim_real_estate_2 
(
    REAL_ESTATE_SID
	,DWH_VALID_FROM_TMSP
	,DWH_VALID_TO_TMSP
	,DWH_VALID_FG
	
	,REAL_ESTATE_NR
	,REAL_ESTATE_NAME
	,REAL_ESTATE_TYPE_CD
	,REAL_ESTATE_TYPE_DESCR
	,REAL_ESTATE_STATUS_CD
	,REAL_ESTATE_STATUS_DESCR
	
	,INT_ORG_SID
	,CURR_INT_ORG_NR
	,INT_ORG_NAME
	,INT_ORG_TYPE_CD
	,INT_ORG_TYPE_DESCR
	
	,OWNERSHIP_TYPE_CD
	,OWNERSHIP_TYPE_DESCR
	,OWNERSHIP_RATIO_TYPE_CD
	,OWNERSHIP_RATIO_TYPE_DESCR
	,OWN_ACQUISITION_FG
	
	,REAL_ESTATE_USG_TYPE_CD
	,REAL_ESTATE_USG_TYPE_DESCR
	,REPLACEMENT_REAL_ESTATE_SID
	,REPLACEMENT_REAL_ESTATE_NR
	,REPLACEMENT_REAL_ESTATE_NAME
	,REAL_ESTATE_REPLACEMENT_TYPE_CD
	,REAL_ESTATE_REPLACEMENT_TYPE_DESCR
	
	,WH_BUILDING_TYPE_CD
	,WH_BUILDING_TYPE_DESCR
	,WH_PURPOSE_CD
	,WH_PURPOSE_DESCR
	,SHARED_USG_FG
	
	,ISO_COUNTRY_CD
	,COUNTRY_NAME
	,CITY_NAME
	,DISTRICT_NAME
	,ZIP
	,STREET_NAME
	,HOUSE_NR
	,LON
	,LAT
	,PO_BOX_NR
	,PHONE_NR
	,FAX_NR
	,EMAIL_ADDR_TXT
	,REPORTING_COUNTRY_CD
	,REPORTING_COUNTRY_NAME
	
	,SALES_AREA_MEAS
	,STORAGE_AREA_MEAS
	,TOTAL_SUBLET_AREA_MEAS
	,RENTED_SUBLET_AREA_MEAS
	,UOM_CD
	,SALES_AREA_M2_MEAS
	,STORAGE_AREA_M2_MEAS
	,TOTAL_SUBLET_AREA_M2_MEAS
	,RENTED_SUBLET_AREA_M2_MEAS
	,TOTAL_PARKING_SPACE_CNT
	,OWN_PARKING_SPACE_CNT
	,UNDERGROUND_PARKING_SPACE_CNT
	,RENTAL_COST_VAL
	,RENTAL_INCOME_VAL
	,CURR_CD
	,RENTAL_COST_EUR_VAL
	,RENTAL_INCOME_EUR_VAL
	
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_LOAD_ID
	,DWH_NODE_CD
)
with 
validity_listing(REAL_ESTATE_SID, DWH_MAPPING_TMSP) as
(
    -- REAL_ESTATE
    SELECT 
        REAL_ESTATE_SID
        ,DWH_VALID_FROM_TMSP
    FROM core_rel.T_REAL_ESTATE_2
    UNION
    SELECT 
        REAL_ESTATE_SID
        ,decode(DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999', DWH_VALID_TO_TMSP, DATEADD(ns, 1, DWH_VALID_TO_TMSP))
    FROM core_rel.T_REAL_ESTATE_2
    UNION
    SELECT 
        REAL_ESTATE_SID
        ,'1900-01-01'::TIMESTAMP
    FROM core_rel.T_REAL_ESTATE_2

    UNION

    -- REAL_ESTATE_STATUS
    SELECT 
        REAL_ESTATE_SID
        ,DWH_VALID_FROM_TMSP
    FROM core_rel.T_REAL_ESTATE_STATUS_2
    UNION
    SELECT 
        REAL_ESTATE_SID
        ,decode(DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999', DWH_VALID_TO_TMSP, DATEADD(ns, 1, DWH_VALID_TO_TMSP))
    FROM core_rel.T_REAL_ESTATE_STATUS_2

    UNION

    -- T_R2D_RESOURCE_ITEM_COST_2
    SELECT 
        REAL_ESTATE_SID
        ,DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_RESOURCE_ITEM_COST_2
    UNION
    SELECT 
        REAL_ESTATE_SID
        ,decode(DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999', DWH_VALID_TO_TMSP, DATEADD(ns, 1, DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_RESOURCE_ITEM_COST_2


    UNION

    -- T_R2D_REAL_ESTATE_REPLACEMENT_2
    SELECT 
        REAL_ESTATE_SID
        ,DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_REAL_ESTATE_REPLACEMENT_2
    UNION
    SELECT 
        REAL_ESTATE_SID
        ,decode(DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999', DWH_VALID_TO_TMSP, DATEADD(ns, 1, DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_REAL_ESTATE_REPLACEMENT_2


    UNION

    -- T_R2D_REAL_ESTATE_STREET_ADDRESS_2
    SELECT 
        REAL_ESTATE_SID
        ,DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_REAL_ESTATE_STREET_ADDRESS_2
    UNION
    SELECT 
        REAL_ESTATE_SID
        ,decode(DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999', DWH_VALID_TO_TMSP, DATEADD(ns, 1, DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_REAL_ESTATE_STREET_ADDRESS_2


    UNION

    -- T_R2D_REAL_ESTATE_PHONE_2
    SELECT 
        REAL_ESTATE_SID
        ,DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_REAL_ESTATE_PHONE_2
    UNION
    SELECT 
        REAL_ESTATE_SID
        ,decode(DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999', DWH_VALID_TO_TMSP, DATEADD(ns, 1, DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_REAL_ESTATE_PHONE_2

    UNION

    -- T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION_2
    SELECT 
        REAL_ESTATE_SID
        ,DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION_2
    UNION
    SELECT 
        REAL_ESTATE_SID
        ,decode(DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999', DWH_VALID_TO_TMSP, DATEADD(ns, 1, DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION_2
)
SELECT 
    vl.REAL_ESTATE_SID
    
    ,vl.DWH_MAPPING_TMSP as VAL_FROM
    ,lead(dateadd(ns, -1, vl.DWH_MAPPING_TMSP),1,'9999-12-31 23:59:59.999999999') 
                over (partition by vl.REAL_ESTATE_SID order by vl.DWH_MAPPING_TMSP asc)    as VAL_TO
    ,(current_timestamp between val_from and val_to) as DWH_VALID_FG
    
    ,re.REAL_ESTATE_NR
    ,nvl(re.REAL_ESTATE_NAME, 'Unbekannt')               as REAL_ESTATE_NAME
    ,nvl(re.REAL_ESTATE_TYPE_CD, '@')                    as REAL_ESTATE_TYPE_CD
    ,nvl(ret.REAL_ESTATE_TYPE_DESCR, 'Unbekannt')        as REAL_ESTATE_TYPE_DESCR
    ,nvl(res.REAL_ESTATE_STATUS_CD, '@')                 as REAL_ESTATE_STATUS_CD
    ,nvl(rest.REAL_ESTATE_STATUS_DESCR, 'Unbekannt')     as REAL_ESTATE_STATUS_DESCR

    ,nvl(reio.INT_ORG_SID, -1)                           as INT_ORG_SID
    ,nvl(reio.CURR_INT_ORG_NR,'@')                       as CURR_INT_ORG_NR
    ,nvl(reio.INT_ORG_NAME, 'Unbekannt')                 as INT_ORG_NAME
    ,nvl(reio.INT_ORG_TYPE_CD,'@')                       as INT_ORG_TYPE_CD  
    ,nvl(reio.INT_ORG_TYPE_DESCR,'Unbekannt')            as INT_ORG_TYPE_DESCR
    
    ,nvl(re.OWNERSHIP_TYPE_CD, '@')                      as OWNERSHIP_TYPE_CD
    ,nvl(ot.OWNERSHIP_TYPE_DESCR, 'Unbekannt')           as OWNERSHIP_TYPE_DESCR
    ,nvl(re.OWNERSHIP_RATIO_TYPE_CD, '@')                as OWNERSHIP_RATIO_TYPE_CD
    ,nvl(ort.OWNERSHIP_RATIO_TYPE_DESCR, 'Unbekannt')    as OWNERSHIP_RATIO_TYPE_DESCR
    ,nvl(re.OWN_ACQUISITION_FG, false)                   as OWN_ACQUISITION_FG


    ,nvl(re.REAL_ESTATE_USG_TYPE_CD, '@')                as REAL_ESTATE_USG_TYPE_CD
    ,nvl(reut.REAL_ESTATE_USG_TYPE_DESCR, 'Unbekannt')   as REAL_ESTATE_USG_TYPE_DESCR

    ,nvl(re_repl.REPLACEMENT_REAL_ESTATE_SID, -1)                    as REPLACEMENT_REAL_ESTATE_SID
    ,re_repl.REPLACEMENT_REAL_ESTATE_NR
    ,nvl(re_repl.REPLACEMENT_REAL_ESTATE_NAME,'Unbekannt')           as REPLACEMENT_REAL_ESTATE_NAME
    ,nvl(re_repl.REAL_ESTATE_REPLACEMENT_TYPE_CD, '@')               as REAL_ESTATE_REPLACEMENT_TYPE_CD
    ,nvl(re_repl.REAL_ESTATE_REPLACEMENT_TYPE_DESCR,'Unbekannt')     as REAL_ESTATE_REPLACEMENT_TYPE_DESCR

    ,nvl(re.WH_BUILDING_TYPE_CD, '@')                    as WH_BUILDING_TYPE_CD
    ,nvl(wbt.WH_BUILDING_TYPE_DESCR, 'Unbekannt')        as WH_BUILDING_TYPE_DESCR
    ,nvl(re.WH_PURPOSE_CD, '@')                          as WH_PURPOSE_CD
    ,nvl(wp.WH_PURPOSE_DESCR, 'Unbekannt')               as WH_PURPOSE_DESCR
    ,nvl(re.SHARED_USG_FG, false)                        as SHARED_USG_FG

    ,nvl(re_addr.ISO_COUNTRY_CD, '@')                   as ISO_COUNTRY_CD
    ,nvl(re_addr.COUNTRY_NAME, 'Unbekannt')             as COUNTRY_NAME
    ,re_addr.CITY_NAME
    ,re_addr.DISTRICT_NAME
    ,re_addr.ZIP
    ,re_addr.STREET_NAME
    ,re_addr.HOUSE_NR
    ,re_addr.LON
    ,re_addr.LAT
    ,NULL										         as PO_BOX_NR
    ,re_tel.PHONE_NR
    ,NULL										         as FAX_NR
    ,'Unbekannt'									     as EMAIL_ADDR_TXT
    ,nvl(re_addr.REPORTING_COUNTRY_CD, '@')              as REPORTING_COUNTRY_CD
    ,nvl(re_addr.REPORTING_COUNTRY_NAME, 'Unbekannt')    as REPORTING_COUNTRY_NAME

    ,re.SALES_AREA_MEAS
    ,re.STORAGE_AREA_MEAS
    ,re.TOTAL_SUBLET_AREA_MEAS
    ,re.RENTED_SUBLET_AREA_MEAS
    ,nvl(re.UOM_CD, '@')                                as UOM_CD
    
    ,case 
        when re.uom_cd = 'SQFT' then re.sales_area_meas / 10.76391042 
        else re.sales_area_meas 
    end 										as SALES_AREA_M2_MEAS
    
    ,case 
        when re.uom_cd = 'SQFT' then re.storage_area_meas / 10.76391042 
        else re.storage_area_meas 
    end 										as STORAGE_AREA_M2_MEAS
    
    ,case 
        when re.uom_cd = 'SQFT' then re.total_sublet_area_meas / 10.76391042 
        else re.total_sublet_area_meas 
    end 										as TOTAL_SUBLET_AREA_M2_MEAS
    
    ,case 
        when re.uom_cd = 'SQFT' then re.rented_sublet_area_meas / 10.76391042 
        else re.rented_sublet_area_meas 
    end 										as RENTED_SUBLET_AREA_M2_MEAS
    
    ,re.TOTAL_PARKING_SPACE_CNT
    ,re.OWN_PARKING_SPACE_CNT
    ,re.UNDERGROUND_PARKING_SPACE_CNT

    ,c_lo.cost_val                                           as RENTAL_COST_VAL
    ,c_li.cost_val                                           as RENTAL_INCOME_VAL
    ,coalesce(c_lo.curr_cd, c_li.curr_cd, '@')               as CURR_CD -- currency for all cost types should be the same
    ,c_lo.cost_eur_val                                       as RENTAL_COST_EUR_VAL
    ,c_li.cost_eur_val                                       as RENTAL_INCOME_EUR_VAL
    
    ,current_timestamp 	    as DWH_CREATED_TMSP
    ,current_timestamp 	    as DWH_UPDATED_TMSP
    ,-1					    as DWH_LOAD_ID
    ,'CORE_REL'			as DWH_NODE_CD
FROM validity_listing vl
    left join core_rel.T_REAL_ESTATE_2 re_2 
                on re.REAL_ESTATE_SID = vl.REAL_ESTATE_SID
                and vl.DWH_MAPPING_TMSP between re.DWH_VALID_FROM_TMSP and re.DWH_VALID_TO_TMSP
    
    left join core_rel.T_REAL_ESTATE_STATUS_2 res 
                on res.REAL_ESTATE_SID = vl.REAL_ESTATE_SID
                and res.real_estate_status_categ_cd = 'BS'
                and vl.DWH_MAPPING_TMSP between res.DWH_VALID_FROM_TMSP and res.DWH_VALID_TO_TMSP

    left join etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION_2 reio
                on reio.REAL_ESTATE_SID = vl.REAL_ESTATE_SID
                and vl.DWH_MAPPING_TMSP between reio.DWH_VALID_FROM_TMSP and reio.DWH_VALID_TO_TMSP

    left join etl.T_R2D_REAL_ESTATE_REPLACEMENT_2 re_repl
                on re_repl.REAL_ESTATE_SID = vl.REAL_ESTATE_SID
                and vl.DWH_MAPPING_TMSP between re_repl.DWH_VALID_FROM_TMSP and re_repl.DWH_VALID_TO_TMSP

    left join etl.T_R2D_REAL_ESTATE_STREET_ADDRESS_2 re_addr
                on re_addr.REAL_ESTATE_SID = vl.REAL_ESTATE_SID
                and vl.DWH_MAPPING_TMSP between re_addr.DWH_VALID_FROM_TMSP and re_addr.DWH_VALID_TO_TMSP

    left join etl.T_R2D_REAL_ESTATE_PHONE_2 re_tel
                on re_tel.REAL_ESTATE_SID = vl.REAL_ESTATE_SID
                and vl.DWH_MAPPING_TMSP between re_tel.DWH_VALID_FROM_TMSP and re_tel.DWH_VALID_TO_TMSP

    left join etl.T_R2D_RESOURCE_ITEM_COST_2 c_lo
                on c_lo.REAL_ESTATE_SID = vl.REAL_ESTATE_SID
                and c_lo.COST_TYPE_CD = 'LO'
                and c_lo.RESOURCE_ITEM_TYPE_CD = 'RE_2'
                and vl.DWH_MAPPING_TMSP between c_lo.DWH_VALID_FROM_TMSP and c_lo.DWH_VALID_TO_TMSP

    left join etl.T_R2D_RESOURCE_ITEM_COST_2 c_li
                on c_li.REAL_ESTATE_SID = vl.REAL_ESTATE_SID
                and c_li.COST_TYPE_CD = 'LI'
                and c_li.RESOURCE_ITEM_TYPE_CD = 'RE_2'                
                and vl.DWH_MAPPING_TMSP between c_li.DWH_VALID_FROM_TMSP and c_li.DWH_VALID_TO_TMSP
    
    -- minor (non-historized) DIMs >>
    left join core_rel.t_real_estate_status_type_2 rest
                    on res.real_estate_status_categ_cd = rest.real_estate_status_categ_cd 
                    and res.real_estate_status_cd = rest.real_estate_status_cd
                    and rest.lang_cd = 'DE'
                    and rest.real_estate_status_categ_cd = 'BS'
    left join core_rel.t_real_estate_type_2 ret
                    on re.real_estate_type_cd = ret.real_estate_type_cd 
                    and ret.lang_cd = 'DE'
    left join core_rel.t_ownership_type_2 ot
                    on re.ownership_type_cd = ot.ownership_type_cd 
                    and ot.lang_cd = 'DE'
    left join core_rel.t_ownership_ratio_type_2 ort
                    on re.ownership_ratio_type_cd = ort.ownership_ratio_type_cd 
                    and ort.lang_cd = 'DE'
    left join core_rel.t_real_estate_usage_type_2 reut
                    on re.real_estate_usg_type_cd = reut.real_estate_usg_type_cd 
                    and reut.lang_cd = 'DE'
    left join core_rel.t_warehouse_building_type_2 wbt
                    on re.wh_building_type_cd = wbt.wh_building_type_cd 
                    and wbt.lang_cd = 'DE'
    left join core_rel.t_warehouse_purpose_2 wp
                    on re.wh_purpose_cd = wp.wh_purpose_cd 
                    and wp.lang_cd = 'DE'
    -- << 
WHERE vl.DWH_MAPPING_TMSP < '9999-12-31 23:59:59.999999999'
;
