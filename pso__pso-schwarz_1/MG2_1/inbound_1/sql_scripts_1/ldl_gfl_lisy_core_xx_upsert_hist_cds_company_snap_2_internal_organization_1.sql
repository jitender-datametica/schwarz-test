
--- STEP 1. CREATE A TEMPORARY TABLE CONTAINING ONE ROW PER COMPANY WITH FLAGS FOR EACH ROLE AS PER LATEST EXTRACT

CREATE OR REPLACE TEMPORARY TABLE ETL.T_TMP_LISY_COMP AS 
WITH 
-- one row per company role
LAST_COMP_ROLE_EXTRACT AS 
(
    SELECT 
		ID
		,IGL_LEGALNAME
		,IGL_NAME
		,IGL_COMPANYTYPECODE
        ,IGL_ISOCODE2
		,SUBSTR(IGL_ASSOCIATIONNUMBER, 1,2)
			||TO_NUMBER(REGEXP_REPLACE(IGL_ASSOCIATIONNUMBER, '[^0-9]', '')) AS INT_ORG_NR

		,SUBSTR(IGL_ASSOCIATIONNUMBER, 1,2)||'|'||TO_NUMBER(REGEXP_REPLACE(IGL_ASSOCIATIONNUMBER, '[^0-9]', '')) PARTY_NAT_KEY_NR

		,LENGTH(IGL_ASSOCIATIONNUMBER) as COMP_NR_LEN
		,CASE
				WHEN REGEXP_LIKE(SUBSTR(IGL_ASSOCIATIONNUMBER, COMP_NR_LEN - 2, 1),  '[0-9]') -- if 3rd char from the back is digit
					THEN SUBSTR(IGL_ASSOCIATIONNUMBER, COMP_NR_LEN - 1, 2) -- get last 2 chars
				ELSE SUBSTR(IGL_ASSOCIATIONNUMBER, COMP_NR_LEN - 2, 3) -- get last 3 chars
			END AS INT_ORG_SHORT_NAME
        ,STATECODE
        ,SINKMODIFIEDON
    FROM ETL_PROCESS.T_TCACHE_LISY_CDS_COMPANY_SNAP_1
    WHERE REGEXP_LIKE(IGL_ASSOCIATIONNUMBER, '^[A-Z]{2}.*')
)
SELECT 
     INT_ORG_NR
    ,PARTY_NAT_KEY_NR
    ,IGL_ISOCODE2  
    ,MAX(SINKMODIFIEDON) AS MAPPING_TMSP
    
    ,MIN_BY(IGL_LEGALNAME, IGL_LEGALNAME) AS LEGAL_NAME -- we want to have the same legal name in all rows that are for the same company
    ,MIN_BY(REGEXP_REPLACE(IGL_NAME, '\\([A-Z]{2,3}\\)', ''), IGL_LEGALNAME) AS INT_ORG_NAME -- we want to have same name in all rows that are for the same company
    ,MIN_BY(INT_ORG_SHORT_NAME, IGL_LEGALNAME) AS INT_ORG_SHORT_NAME
   
   -- country_org_cd is populated only when the company has an active role of a country_1 organization
   ,CASE
        WHEN SUM(IFF(IGL_COMPANYTYPECODE = '285540001' and STATECODE = 0, 1, 0)) > 0 THEN IGL_ISOCODE2
        ELSE NULL
    END AS COUNTRY_ORG_CD

    -- flags are True if we have a record with this role for the company and its state is active 
    ,SUM(IFF(IGL_COMPANYTYPECODE = '285540002' and STATECODE = 0, 1, 0)) > 0 as IS_SALES_COMPANY_FG
    ,SUM(IFF(IGL_COMPANYTYPECODE = '285540000' and STATECODE = 0, 1, 0)) > 0 as IS_DELIV_COMPANY_FG
    ,SUM(IFF(IGL_COMPANYTYPECODE = '285540003' and STATECODE = 0, 1, 0)) > 0 as IS_EXPANSION_COMPANY_FG
    ,SUM(IFF(IGL_COMPANYTYPECODE = '285540006' and STATECODE = 0, 1, 0)) > 0 as IS_BAL_SHEET_COMPANY_FG
    ,SUM(IFF(IGL_COMPANYTYPECODE = '285540005' and STATECODE = 0, 1, 0)) > 0 as IS_OWNER_COMPANY_FG
    ,SUM(IFF(IGL_COMPANYTYPECODE = '285540001' and STATECODE = 0, 1, 0)) > 0 as IS_COUNTRY_ORG_FG

FROM LAST_COMP_ROLE_EXTRACT
-- reduce the dataset to 1 row per company
GROUP BY 
    INT_ORG_NR
    ,PARTY_NAT_KEY_NR
    ,IGL_ISOCODE2
;

-- STEP 2. CREATE A TEMPORARY TABLE WITH THE VALIDITY_1 DATES OF ALL COMPANY ROLE - STORE RELATIONS 

CREATE OR REPLACE TEMPORARY TABLE ETL.T_TMP_LISY_COMP_REL AS 
WITH
LAST_REL_EXTRACT AS 
(
    SELECT
		RDG.IGL_REGIONID					as COMP_ROLE_ID
		,SUBSTR(C.IGL_ASSOCIATIONNUMBER, 1,2)
			||TO_NUMBER(REGEXP_REPLACE(C.IGL_ASSOCIATIONNUMBER, '[^0-9]', '')) AS INT_ORG_NR
        ,RDG.IGL_COMPANYTYPECODE			as COMP_ROLE_TYPE_CD
		,TO_DATE(RDG.IGL_VALIDFROMDATE) 	as VAL_FROM
		,NVL(TO_DATE(RDG.IGL_VALIDTODATE), '9999-12-31')	as VAL_TO	-- for some relations igl_validtodate is missing, so we take the default maximum assuming that if the validity_1 interval is open, the relation must be still valid		
    FROM ETL_PROCESS.T_TCACHE_LISY_CDS_REGIONRELATIONHISTORY_SNAP_1 RDG --- EXTERNAL TABLE CREATED FROM CDS_REGIONRELATIONHISTORY IN DATASTORE
    JOIN ETL_PROCESS.T_TCACHE_LISY_CDS_COMPANY_SNAP_1 C
        ON C.ID = COMP_ROLE_ID
        AND C.IGL_COMPANYTYPECODE = COMP_ROLE_TYPE_CD
 QUALIFY ROW_NUMBER() OVER
			--- DEDUPLICATE CDS_REGIONRELATIONHISTORY BY COMPANY ID (IGL_REGIONID), COMPANY ROLE (IGL_COMPANYTYPECODE) AND STARTING DATE OF VALIDITY_1 OF THE RELATIONSHIP BETWEEN THE GIVEN COMPANY (AND ITS ROLE) AND ANY STORE
			(
				PARTITION BY 
					RDG.IGL_REGIONID
					, RDG.IGL_COMPANYTYPECODE
					, RDG.IGL_VALIDFROMDATE
				ORDER BY RDG.SINKMODIFIEDON DESC
			) = 1
)
-- get start/end date for each role type (with stores)
, REL_DATES AS 
(
	SELECT 
		INT_ORG_NR
		,COMP_ROLE_TYPE_CD
        ,VAL_FROM
        ,VAL_TO
        
		,MAX(VAL_TO) OVER (
				PARTITION BY INT_ORG_NR, COMP_ROLE_TYPE_CD 
				ORDER BY VAL_FROM ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS PREV_MAX_VAL_TO
        
		,CASE
				WHEN PREV_MAX_VAL_TO IS NULL THEN 0 -- first row, flag for gap is 0
				WHEN VAL_FROM > PREV_MAX_VAL_TO + 1 THEN 1
				ELSE 0
			END AS HAS_GAP_FG
	FROM LAST_REL_EXTRACT
)
-- check for validity_1 gaps for each role
, REL_DATES_WITH_GROUPS AS
(
    SELECT 
        rd.*
        ,SUM(HAS_GAP_FG) OVER (
				PARTITION BY INT_ORG_NR, COMP_ROLE_TYPE_CD
				ORDER BY VAL_FROM asc, HAS_GAP_FG desc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			)                as TIME_GROUP_ID
    FROM REL_DATES rd
)
SELECT 
    INT_ORG_NR
    ,COMP_ROLE_TYPE_CD
    ,TIME_GROUP_ID
    ,MIN(VAL_FROM) AS VAL_FROM
    ,MAX(VAL_TO) AS VAL_TO
FROM REL_DATES_WITH_GROUPS
GROUP BY 
    INT_ORG_NR
    ,COMP_ROLE_TYPE_CD
    ,TIME_GROUP_ID
;


-- STEP 3. HISTORIZE ROLE CHANGES FOR EACH COMPANY
CREATE OR REPLACE TABLE ETL.T_TMP_LISY_COMP_REL_TF_1 AS 
WITH CAL_DT_FLAGS AS 
(
SELECT 
    C.INT_ORG_NR
    ,CD.CAL_DT

    ,C.PARTY_NAT_KEY_NR
    ,C.INT_ORG_NAME
    ,C.LEGAL_NAME
    ,C.INT_ORG_SHORT_NAME
    ,CASE
        WHEN (CD.CAL_DT < TO_DATE(C.MAPPING_TMSP) AND CO.VAL_FROM IS NOT NULL)
            OR (CD.CAL_DT >= TO_DATE(C.MAPPING_TMSP) AND C.IS_COUNTRY_ORG_FG = TRUE)
            OR C.INT_ORG_NR = 'MT99'
        THEN C.COUNTRY_ORG_CD
        ELSE NULL
    END AS COUNTRY_ORG_CD
    , CASE 
        WHEN (CD.CAL_DT < TO_DATE(C.MAPPING_TMSP) AND DC.VAL_FROM IS NOT NULL)
            OR (CD.CAL_DT >= TO_DATE(C.MAPPING_TMSP) AND C.IS_DELIV_COMPANY_FG = TRUE)
        THEN TRUE
        ELSE FALSE
    END AS IS_DELIV_COMPANY_FG
    , CASE 
        WHEN (CD.CAL_DT < TO_DATE(C.MAPPING_TMSP) AND SC.VAL_FROM IS NOT NULL)
            OR (CD.CAL_DT >= TO_DATE(C.MAPPING_TMSP) AND C.IS_SALES_COMPANY_FG = TRUE)
        THEN TRUE
        ELSE FALSE
    END AS IS_SALES_COMPANY_FG
    , CASE
        WHEN (CD.CAL_DT < TO_DATE(C.MAPPING_TMSP) AND EC.VAL_FROM IS NOT NULL)
            OR (CD.CAL_DT >= TO_DATE(C.MAPPING_TMSP) AND C.IS_EXPANSION_COMPANY_FG = TRUE)
        THEN TRUE
        ELSE FALSE
    END AS IS_EXPANSION_COMPANY_FG
    , CASE
        WHEN (CD.CAL_DT < TO_DATE(C.MAPPING_TMSP) AND OC.VAL_FROM IS NOT NULL)
            OR (CD.CAL_DT >= TO_DATE(C.MAPPING_TMSP) AND C.IS_OWNER_COMPANY_FG = TRUE)
        THEN TRUE
        ELSE FALSE
    END AS IS_OWNER_COMPANY_FG
    , CASE
        WHEN (CD.CAL_DT < TO_DATE(C.MAPPING_TMSP) AND BC.VAL_FROM IS NOT NULL)
            OR (CD.CAL_DT >= TO_DATE(C.MAPPING_TMSP) AND C.IS_BAL_SHEET_COMPANY_FG = TRUE)
        THEN TRUE
        ELSE FALSE
    END AS IS_BAL_SHEET_COMPANY_FG
    , CASE
        WHEN (CD.CAL_DT < TO_DATE(C.MAPPING_TMSP) AND CO.VAL_FROM IS NOT NULL)
            OR (CD.CAL_DT >= TO_DATE(C.MAPPING_TMSP) AND C.IS_COUNTRY_ORG_FG = TRUE)
            OR C.INT_ORG_NR = 'MT99'
        THEN TRUE
        ELSE FALSE
    END AS IS_COUNTRY_ORG_FG
FROM ETL.T_TMP_LISY_COMP C
    CROSS JOIN CORE_DIM.T_DIM_CALENDAR_DATE_1 CD

    -- GET THE VALIDITY_1 DATES FOR THE ROLE DELIVERY COMPANY
    LEFT JOIN ETL.T_TMP_LISY_COMP_REL DC
        ON C.INT_ORG_NR = DC.INT_ORG_NR
        AND CD.CAL_DT BETWEEN DC.VAL_FROM AND DC.VAL_TO
        AND DC.COMP_ROLE_TYPE_CD = '285540000'

    -- GET THE VALIDITY_1 DATES FOR THE ROLE COUNTRY_1 ORGANIZATION
    LEFT JOIN ETL.T_TMP_LISY_COMP_REL CO
        ON C.INT_ORG_NR = CO.INT_ORG_NR
        AND CD.CAL_DT BETWEEN CO.VAL_FROM AND CO.VAL_TO
        AND CO.COMP_ROLE_TYPE_CD = '285540001'
    
    -- GET THE VALIDITY_1 DATES FOR THE ROLE SALES_1 COMPANY
    LEFT JOIN ETL.T_TMP_LISY_COMP_REL SC
        ON C.INT_ORG_NR = SC.INT_ORG_NR
        AND CD.CAL_DT BETWEEN SC.VAL_FROM AND SC.VAL_TO
        AND SC.COMP_ROLE_TYPE_CD = '285540002'

    -- GET THE VALIDITY_1 DATES FOR THE ROLE EXPANSION COMPANY
    LEFT JOIN ETL.T_TMP_LISY_COMP_REL EC
        ON C.INT_ORG_NR = EC.INT_ORG_NR
        AND CD.CAL_DT BETWEEN EC.VAL_FROM AND EC.VAL_TO
        AND EC.COMP_ROLE_TYPE_CD = '285540003'
    
    -- GET THE VALIDITY_1 DATES FOR THE ROLE OWNER COMPANY
    LEFT JOIN ETL.T_TMP_LISY_COMP_REL OC
        ON C.INT_ORG_NR = OC.INT_ORG_NR
        AND CD.CAL_DT BETWEEN OC.VAL_FROM AND OC.VAL_TO
        AND OC.COMP_ROLE_TYPE_CD = '285540005'

    -- GET THE VALIDITY_1 DATES FOR THE ROLE BALANCE SHEET COMPANY
    LEFT JOIN ETL.T_TMP_LISY_COMP_REL BC
        ON C.INT_ORG_NR = BC.INT_ORG_NR
        AND CD.CAL_DT BETWEEN BC.VAL_FROM AND BC.VAL_TO
        AND BC.COMP_ROLE_TYPE_CD = '285540006'
WHERE 1=1
    AND CD.CAL_DT BETWEEN '1900-01-01' AND CURRENT_DATE -- current_date will always be >= extraction date from the latest company export
)
, FLAG_CHANGES AS 
(
SELECT
    *
    , SHA2('#' || IS_DELIV_COMPANY_FG ||
          '#' || IS_COUNTRY_ORG_FG ||
          '#' || IS_SALES_COMPANY_FG ||
          '#' || IS_EXPANSION_COMPANY_FG ||
          '#' || IS_OWNER_COMPANY_FG ||
          '#' || IS_BAL_SHEET_COMPANY_FG) AS HASH_VALUE
    , CASE
        WHEN HASH_VALUE != LAG(HASH_VALUE, 1, '-') OVER (PARTITION BY INT_ORG_NR ORDER BY CAL_DT) 
          THEN 1
          ELSE 0
    END AS CHANGE_FG
FROM CAL_DT_FLAGS
)
, FLAG_CHANGE_GROUPS AS
(
SELECT
*
, SUM(CHANGE_FG) OVER (PARTITION BY INT_ORG_NR ORDER BY CAL_DT) AS GROUP_ID
FROM FLAG_CHANGES
)
SELECT 
    FCG.INT_ORG_NR
    , FCG.PARTY_NAT_KEY_NR
    , TO_TIMESTAMP(MIN(FCG.CAL_DT)) AS DWH_VALID_FROM
    , CASE
        WHEN MAX(FCG.CAL_DT) >= CURRENT_DATE THEN '9999-12-31 23:59:59.99999999999' -- since the source does not provide info about future role changes, we take the current status_1 and set it as valid until our default maximum 9999-12-31
        ELSE DATEADD(ns, -1, DATEADD(DAY, 1, TO_TIMESTAMP(MAX(FCG.CAL_DT)))) 
    END AS DWH_VALID_TO
    , FCG.INT_ORG_NAME
    , FCG.LEGAL_NAME
    , FCG.INT_ORG_SHORT_NAME
    , CASE   
        WHEN FCG.IS_COUNTRY_ORG_FG = TRUE 
            AND FCG.COUNTRY_ORG_CD = 'NI'
        THEN 'GBP' -- NI data from LISY is for Northern Ireland, and not NIcaragua.
        WHEN FCG.IS_COUNTRY_ORG_FG = TRUE 
            AND FCG.PARTY_NAT_KEY_NR NOT IN ('FR|1', 'FR|2', 'SI|5', 'CZ|2', 'DE|10', 'DE|79') 
        THEN CNTR.CURR_CD
        ELSE NULL
    END AS CURR_CD
    , CASE
        WHEN FCG.PARTY_NAT_KEY_NR IN ('FR|1', 'FR|2', 'SI|5', 'CZ|2', 'DE|10', 'DE|79') THEN NULL
        ELSE FCG.COUNTRY_ORG_CD
    END AS COUNTRY_ORG_CD
    , CASE
        WHEN FCG.COUNTRY_ORG_CD = 'NI' THEN 'Nordirland'
        ELSE CNTR.COUNTRY_NAME
    END AS COUNTRY_ORG_NAME
    , FCG.IS_SALES_COMPANY_FG
    , FCG.IS_DELIV_COMPANY_FG
    , FCG.IS_EXPANSION_COMPANY_FG
    , FCG.IS_BAL_SHEET_COMPANY_FG
    , FCG.IS_OWNER_COMPANY_FG
    , CASE
        WHEN FCG.PARTY_NAT_KEY_NR IN ('FR|1', 'FR|2', 'SI|5', 'CZ|2', 'DE|10', 'DE|79') THEN FALSE
        ELSE FCG.IS_COUNTRY_ORG_FG
    END AS IS_COUNTRY_ORG_FG
FROM FLAG_CHANGE_GROUPS FCG
    LEFT JOIN CORE_REL.T_COUNTRY_1 CNTR
        ON FCG.COUNTRY_ORG_CD = CNTR.ISO_COUNTRY_CD
        AND CNTR.DWH_VALID_FG = TRUE
GROUP BY 
    INT_ORG_NR
    , PARTY_NAT_KEY_NR
    , INT_ORG_NAME
    , LEGAL_NAME
    , INT_ORG_SHORT_NAME
    , CURR_CD
    , COUNTRY_ORG_CD
    , COUNTRY_ORG_NAME
    , IS_SALES_COMPANY_FG
    , IS_DELIV_COMPANY_FG
    , IS_EXPANSION_COMPANY_FG
    , IS_BAL_SHEET_COMPANY_FG
    , IS_OWNER_COMPANY_FG
    , IS_COUNTRY_ORG_FG
    , GROUP_ID
;

--- STEP 4 - NKC Additions

INSERT INTO meta.t_party_key_1 
(
        party_sid,
        party_key_type_cd,
        party_nat_key_nr,
        dwh_created_tmsp,
        dwh_updated_tmsp,
        dwh_valid_from_tmsp,
        dwh_valid_to_tmsp
        ,dwh_valid_fg
        ,dwh_node_cd
        ,dwh_load_id
)
(
SELECT  
        max_seq + row_number() over(order by 1) AS party_sid,
        t1.int_org_key_type_cd,
        t1.int_org_natural_key AS natural_key,
        current_timestamp,
        current_timestamp,
        current_timestamp,
        '9999-12-31 23:59:59.999999999'
        ,TRUE
        ,t1.dwh_node_cd
        ,'${LOAD_ID}'

FROM (SELECT t1.dwh_node_cd, int_org_key_type_cd, int_org_natural_key
        FROM (SELECT 'LISY' AS dwh_node_cd, 'COMPANY' AS int_org_key_type_cd, UPPER(PARTY_NAT_KEY_NR) AS int_org_natural_key FROM ETL.T_TMP_LISY_COMP_REL_TF_1  t1_1) t1_1
        GROUP BY t1.dwh_node_cd, int_org_key_type_cd, int_org_natural_key) t1_1
        
CROSS JOIN (SELECT COALESCE(MAX(party_sid),0) AS max_seq FROM meta.t_party_key_1) AS max_seq

WHERE 
natural_key IS NOT NULL AND 
NOT EXISTS
        (
         SELECT 1 FROM meta.t_party_key_1 t2 
         WHERE
         UPPER(t2.party_key_type_cd) = t1.int_org_key_type_cd AND
         current_timestamp between t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND 
         UPPER(t2.party_nat_key_nr) = t1.int_org_natural_key
        ) 
);

/* Design is to generate records with full history and SID in bespoke SQL.
   Pre-existing COMPANY internal organisation data will be 
   replaced using the latest data.
*/     
   
DELETE FROM CORE_REL.T_INTERNAL_ORGANIZATION_1 IO
WHERE INT_ORG_TYPE_CD = 'COMPANY'
AND INT_ORG_SID IN (
    SELECT DISTINCT PARTY_SID 
        FROM META.T_PARTY_KEY_1 INT_ORG_SID 
        JOIN ETL.T_TMP_LISY_COMP_REL_TF_1 TF
        ON INT_ORG_SID.DWH_VALID_FG = TRUE
        AND INT_ORG_SID.PARTY_KEY_TYPE_CD = 'COMPANY'
        AND UPPER(INT_ORG_SID.PARTY_NAT_KEY_NR) = UPPER(TF.PARTY_NAT_KEY_NR)
        )
;

--- STEP 5 -- Transform to target (With SID)


INSERT INTO CORE_REL.T_INTERNAL_ORGANIZATION_1
(
    INT_ORG_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    ,INT_ORG_TYPE_CD
    ,INT_ORG_NR
    ,INT_ORG_NAME
    ,OPEN_DT
    ,PLANNED_OPEN_DT
    ,CLOSE_DT
    ,CURR_CD
    ,HOLIDAY_STORE_FG
    ,LEGAL_NAME
    ,VAT_NR
    ,COUNTRY_ORG_CD
    ,COMMENT_TXT
    ,IS_SALES_COMPANY_FG
    ,IS_DELIV_COMPANY_FG
    ,IS_COUNTRY_ORG_FG
    ,IS_EXPANSION_COMPANY_FG
    ,IS_BAL_SHEET_COMPANY_FG
    ,IS_OWNER_COMPANY_FG
    ,IS_TRUST_FG
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
    ,INT_ORG_SHORT_NAME
    ,COUNTRY_ORG_NAME
)
SELECT
     INT_ORG_SID.PARTY_SID
    ,TF.DWH_VALID_FROM
    ,TF.DWH_VALID_TO
    ,CASE 
        WHEN CURRENT_TIMESTAMP BETWEEN TF.DWH_VALID_FROM AND TF.DWH_VALID_TO THEN TRUE
        ELSE FALSE        
     END AS DWH_VALID_FG
    ,'COMPANY'
    ,INT_ORG_NR
    ,NVL(INT_ORG_NAME, ('Unbekannt' || ' (' || INT_ORG_NR || ')'))
    ,NULL
    ,NULL
    ,NULL
    ,CURR_CD
    ,NULL
    ,LEGAL_NAME
    ,NULL
    ,COUNTRY_ORG_CD
    ,NULL
    ,IS_SALES_COMPANY_FG
    ,IS_DELIV_COMPANY_FG
    ,IS_COUNTRY_ORG_FG
    ,IS_EXPANSION_COMPANY_FG
    ,IS_BAL_SHEET_COMPANY_FG
    ,IS_OWNER_COMPANY_FG
    ,FALSE
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
    ,'${LOAD_ID}'
    ,'LISY'
    ,INT_ORG_SHORT_NAME
    ,COUNTRY_ORG_NAME
FROM ETL.T_TMP_LISY_COMP_REL_TF_1 TF
LEFT OUTER JOIN META.T_PARTY_KEY_1 INT_ORG_SID 
ON INT_ORG_SID.DWH_VALID_FG = TRUE
AND INT_ORG_SID.PARTY_KEY_TYPE_CD = 'COMPANY'
AND UPPER(INT_ORG_SID.PARTY_NAT_KEY_NR) = UPPER(TF.PARTY_NAT_KEY_NR)
;






-----------------------------------------------
-- Originally a post-load script for int_org before it was converted to an sql-only transform
-----------------------------------------------

BEGIN TRANSACTION;

-- Note: any record for the previous country_1 organiation that started after the new organization become active should have its flag set to FALSE.
-- records for previous Country_1 Orgs that started before but end after the new organization becomes active should have their end-date adjusted and the gap should be filled with a record for the previous organization with flag FALSE (the insert in ""M5"")

MERGE into core_rel.T_INTERNAL_ORGANIZATION_1 trg
USING
(
    with 
    -- all country_1 organization for given country_1 from the prev loads for this country_1 (excl the last load)
    prev as
    (
        select *
        from core_rel.t_internal_organization_1
        where is_country_org_fg = TRUE
            and int_org_type_cd = 'COMPANY'
        QUALIFY 1=1
            -- if we have more than one SID as country_1 org for a country_1
            and count(distinct int_org_sid) over (partition by country_org_cd) > 1
            and rank() over (partition by country_org_cd order by dwh_load_id desc) > 1
            
    )
    -- all country_1 organization for given country_1 from the last load for this country_1
    , curr as
    (
        select *
        from core_rel.t_internal_organization_1
        where is_country_org_fg = TRUE
            and int_org_type_cd = 'COMPANY'
        QUALIFY 1=1
            -- if we have more than one SID as country_1 org for a country_1
            and count(distinct int_org_sid) over (partition by country_org_cd) > 1
            and rank() over (partition by country_org_cd order by dwh_load_id desc) = 1
    )
    select 
        prev.int_org_sid
        ,prev.dwh_valid_from_tmsp prev_valid_from
        ,prev.dwh_valid_to_tmsp prev_valid_to
        ,case
            when prev.dwh_valid_from_tmsp >= min(curr.dwh_valid_from_tmsp) then 'UPD FLAG'
            else 'UPD TMSP'
        end as action_type
        ,min(curr.dwh_valid_from_tmsp) curr_valid_from
        ,dateadd('ns', -1, curr_valid_from) new_valid_to
        ,prev.country_org_cd
    from prev
        join curr on prev.country_org_cd = curr.country_org_cd
                and prev.dwh_valid_to_tmsp > curr.dwh_valid_from_tmsp
    group by 
        prev.int_org_sid
        ,prev.dwh_valid_from_tmsp
        ,prev.dwh_valid_to_tmsp
        ,prev.country_org_cd
) src
on trg.int_org_sid = src.int_org_sid
    and trg.dwh_valid_from_tmsp = src.prev_valid_from
WHEN MATCHED THEN UPDATE
    set trg.is_country_org_fg = decode(src.ACTION_TYPE, 'UPD FLAG', false, true)
        ,trg.dwh_valid_to_tmsp = decode(src.ACTION_TYPE, 'UPD TMSP', new_valid_to, prev_valid_to)
        ,trg.DWH_UPDATED_TMSP = current_timestamp
        ,trg.DWH_LOAD_ID = '${LOAD_ID}'
;

INSERT into core_rel.T_INTERNAL_ORGANIZATION_1
(
    INT_ORG_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    ,INT_ORG_TYPE_CD
    ,INT_ORG_NR
    ,INT_ORG_NAME
    ,OPEN_DT
    ,PLANNED_OPEN_DT
    ,CLOSE_DT
    ,CURR_CD
    ,HOLIDAY_STORE_FG
    ,LEGAL_NAME
    ,VAT_NR
    ,COUNTRY_ORG_CD
    ,COMMENT_TXT
    ,IS_SALES_COMPANY_FG
    ,IS_DELIV_COMPANY_FG
    ,IS_COUNTRY_ORG_FG
    ,IS_EXPANSION_COMPANY_FG
    ,IS_BAL_SHEET_COMPANY_FG
    ,IS_OWNER_COMPANY_FG
    ,IS_TRUST_FG
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
with
other_gaps as
(
    SELECT
        io.*
        ,CASE
            WHEN DWH_VALID_TO_TMSP < TIMESTAMP '9999-12-31 23:59:59.999' then dateadd(ns, 1, DWH_VALID_TO_TMSP)
            ELSE DWH_VALID_TO_TMSP
        END as ADJ_VALID_TO_TMSP
        ,lead(DWH_VALID_FROM_TMSP, 1, TIMESTAMP '9999-12-31 23:59:59.999')
                    over (partition by INT_ORG_SID order by DWH_VALID_FROM_TMSP) as NEXT_VALID_FROM_TSMP 
    FROM core_rel.T_INTERNAL_ORGANIZATION_1 io
    where io.INT_ORG_TYPE_CD = 'COMPANY'
    -- To have a gap, the current row must end more than 1ns before next row begins
    QUALIFY ADJ_VALID_TO_TMSP < NEXT_VALID_FROM_TSMP
        and io.IS_COUNTRY_ORG_FG = TRUE
)
SELECT 
    INT_ORG_SID
    ,ADJ_VALID_TO_TMSP      as DWH_VALID_FROM_TMSP
    ,CASE
        WHEN NEXT_VALID_FROM_TSMP < TIMESTAMP '9999-12-31 23:59:59.999' THEN dateadd(ns, -1, NEXT_VALID_FROM_TSMP)
        ELSE NEXT_VALID_FROM_TSMP
    END                     as CALC_DWH_VALID_TO_TMSP
    ,(current_timestamp between ADJ_VALID_TO_TMSP and CALC_DWH_VALID_TO_TMSP) as DWH_VALID_FG
    ,INT_ORG_TYPE_CD
    ,INT_ORG_NR
    ,io.INT_ORG_NAME
    ,io.OPEN_DT
    ,io.PLANNED_OPEN_DT
    ,io.CLOSE_DT
    ,io.CURR_CD
    ,io.HOLIDAY_STORE_FG
    ,io.LEGAL_NAME
    ,io.VAT_NR
    ,io.COUNTRY_ORG_CD
    ,io.COMMENT_TXT
    ,io.IS_SALES_COMPANY_FG
    ,io.IS_DELIV_COMPANY_FG
    ,FALSE  as IS_COUNTRY_ORG_FG
    ,io.IS_EXPANSION_COMPANY_FG
    ,io.IS_BAL_SHEET_COMPANY_FG
    ,io.IS_OWNER_COMPANY_FG
    ,io.IS_TRUST_FG
    ,current_timestamp
    ,current_timestamp
    ,io.dwh_load_id
    ,'LISY'
    
FROM other_gaps io
;

COMMIT;
