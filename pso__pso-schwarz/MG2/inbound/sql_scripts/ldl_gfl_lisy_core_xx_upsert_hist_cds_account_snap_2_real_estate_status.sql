INSERT INTO  ETL.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        REAL_ESTATE_KEY_TYPE_CD,
        REAL_ESTATE_NK,
        REAL_ESTATE_STATUS_CATEG_CD,
        REAL_ESTATE_STATUS_CD,
        REAL_ESTATE_STATUS_REASON_CD,
        COMMENT_TXT,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        DWH_ENDING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)

with src_sel AS
(
SELECT * FROM etl_process.t_tcache_lisy_cds_account_snap
WHERE IGL_ACCOUNTTYPECODE IN (285540000, 285540009) -- real estate associated with stores and special sale stores,a
AND IGL_NUMBER IS NOT NULL -- (only objects with assigned object number should be kept)
AND IGL_STATUSOBJEKTCODE NOT IN (285540000, 285540001) -- we are only interested in statuses after there has been a contract for the store - the event that marks the beginning of the lifecycle of the real estate object and provides it with a number"
AND DELETED <> 'x'
)

,src as
(
    -- UC
    select 
        igl_number
        ,igl_isocode2
        ,'UC' as real_estate_status_cd
        ,null as real_estate_status_reason_cd
        ,least_ignore_nulls(igl_contractdate, igl_precontractdate) as status_start_tmsp
        ,10 as lifecycle_order_nr
    from src_sel
    
    union all
    
    -- OP
    select 
        igl_number
        ,igl_isocode2
        ,'OP' as real_estate_status_cd
        ,null as real_estate_status_reason_cd
        ,igl_neodate as status_start_tmsp
        ,20 as lifecycle_order_nr
    from etl_process.t_tcache_lisy_cds_account_snap
    
    union all
    
    -- CL
    select 
        igl_number
        ,igl_isocode2
        ,'CL' as real_estate_status_cd
        ,CASE
               when igl_closingreasoncode = 285540000 then 'BS_CL_NEP'
               when igl_closingreasoncode = 285540001 then 'BS_CL_DNC'
               when igl_closingreasoncode = 285540002 then 'BS_CL_CAI'
               when igl_closingreasoncode = 285540003 then 'BS_CL_LEO'
               when igl_closingreasoncode = 285540004 then 'BS_CL_LRE'
               when igl_closingreasoncode = 285540005 then 'BS_CL_TFP'
               when igl_closingreasoncode = 285540006 then 'BS_CL_BLC'
               when igl_closingreasoncode = 285540007 then 'BS_CL_BDS'
               when igl_closingreasoncode = 285540008 then 'BS_CL_RPL'
               when igl_closingreasoncode = 285540009 then 'BS_CL_MST'
               when igl_closingreasoncode = 285540010 then 'BS_CL_OTH'
        END as real_estate_status_reason_cd
        ,igl_closingdate as status_start_tmsp
        ,30 as lifecycle_order_nr
    from etl_process.t_tcache_lisy_cds_account_snap
    
    
    union all
    
    -- TE
    select 
        igl_number
        ,igl_isocode2
        ,'TE' as real_estate_status_cd
        ,null real_estate_status_reason_cd
        ,igl_finalsettlementdate as status_start_tmsp
        ,40 as lifecycle_order_nr
    from etl_process.t_tcache_lisy_cds_account_snap
    
    union all
    
    -- CN
    select 
        igl_number
        ,igl_isocode2
        ,'CN' as real_estate_status_cd
        ,case
           when igl_noimplementationreasoncode = 285540000 then 'BS_CN_NBP'
           when igl_noimplementationreasoncode = 285540001 then 'BS_CN_UCO'
           when igl_noimplementationreasoncode = 285540002 then 'BS_CN_ULO'
           when igl_noimplementationreasoncode = 285540003 then 'BS_CN_OTL'
           when igl_noimplementationreasoncode = 285540004 then 'BS_CN_NCA'
           when igl_noimplementationreasoncode = 285540005 then 'BS_CN_NAP'
           when igl_noimplementationreasoncode = 285540006 then 'BS_CN_CDO'
        end real_estate_status_reason_cd
        ,igl_noimplementationdate as status_start_tmsp
        ,11 as lifecycle_order_nr  -- after Under contract, but before Open - > makes no sense to have Cancelled Implementation if it is already opened
    from etl_process.t_tcache_lisy_cds_account_snap
)
,src_eliminate_same_dates as 
(
    SELECT *
    FROM src
    -- for some buildings two statuses could be set on the same date  - Closed and Termniated for example
    -- we keep the Status which comes later in the lifecycle of a building  - Termninated in this case. 
    -- Store was closed and immediatelly terminated, so it spend 0 days in stasus ""Closed""
    QUALIFY ROW_NUMBER() over (partition by igl_number, status_start_tmsp order by lifecycle_order_nr desc) = 1
)
,transformed as (select 
    igl_number
    ,igl_isocode2
    ,real_estate_status_cd
    ,real_estate_status_reason_cd
    ,status_start_tmsp
    ,lead(dateadd(ns, -1, status_start_tmsp), 1, '9999-12-31 23:59:59.999999999 ') over (partition by igl_number order by status_start_tmsp asc) status_end_tmsp
from src_eliminate_same_dates
where status_start_tmsp is not null
)

SELECT
        'RE' AS REAL_ESTATE_KEY_TYPE_CD,
        IGL_ISOCODE2 || '|' || LTRIM(SUBSTR(IGL_NUMBER, 3, 7), '0#') AS REAL_ESTATE_NK,
        'BS' AS REAL_ESTATE_STATUS_CATEG_CD,
        REAL_ESTATE_STATUS_CD,
        REAL_ESTATE_STATUS_REASON_CD,
        NULL AS COMMENT_TXT,
        'LISY' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        STATUS_START_TMSP AS DWH_MAPPING_TMSP,
        STATUS_END_TMSP AS DWH_ENDING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'LISY' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
from transformed
;


