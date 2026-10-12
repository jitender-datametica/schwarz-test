/* 
This process is designed to allocate the same orginal SID to all descendant stores of that original store.

This is because of a blurring of the definition of logical stores and physical stores.
For example, LIDL Berlin may originally be identified as store100, however if that physical building is demolished
and replaced by a newly constructed building then it is a different physical store (building) called store200, 
but it is really still LIDL Berlin.

Business reports should show KPIs against the one 'original' store100 consistently, not the different buildings (store 100, 200, etc etc).
Therefore, in data terms, all stores should eb assigned the same original SID.
 
The ETL framework does not currently facilitate this; the framework is designed to simply allocate a new SID for any new NK.

The cds_Account(store 3) worksheet in the t_internal_organization_2 mapping spec, specifies this process and is implemented
here.

*/ 

BEGIN TRANSACTION;

            
DELETE FROM META.T_PARTY_KEY_2 -- Prevent any concurrent access to this keyspace
WHERE 1=2;


INSERT INTO META.T_PARTY_KEY_2 
(
        PARTY_SID,
        PARTY_KEY_TYPE_CD,
        PARTY_NAT_KEY_NR,
        DWH_CREATED_TMSP,
        DWH_UPDATED_TMSP,
        DWH_VALID_FROM_TMSP,
        DWH_VALID_TO_TMSP,
        DWH_VALID_FG,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
(
WITH 
STORES AS 
(
    SELECT 
        *
    FROM ETL_PROCESS.T_TCACHE_LISY_CDS_ACCOUNT_SNAP_2
    WHERE 1=1
        AND IGL_NUMBER IS NOT NULL
        AND IGL_ACCOUNTTYPECODE IN (285540000, 285540009)
        AND (IGL_NEODATE IS NOT NULL OR IGL_CLOSINGDATE IS NOT NULL OR IGL_EXPECTEDOPENINGDATE IS NOT NULL)
)
, RECUR_BASE AS
(
    -- followers/next/replacement stores taken using "IGL_REPLACEMENTID" of the previous
	-- "root store" is replaced by "next store"
	SELECT 
        R.ACCOUNTID
        ,R.IGL_NUMBER
        ,R.IGL_SUBSTITUTEFORID
        ,NS.ACCOUNTID AS NS_ACCOUNT_ID
        ,NS.IGL_NUMBER AS NS_IGL_NUMBER
        ,NS.IGL_NEODATE AS NS_OPEN_DT
        ,NS.IGL_CLOSINGDATE AS NS_CLOSE_DT

    FROM STORES R -- root store
        JOIN STORES NS -- next store 
			ON R.IGL_REPLACEMENTID = NS.ACCOUNTID

    UNION
 
    -- followers/next/replacement stores taken using their "IGL_SUBSTITUTEFORID"
	-- "next store" is substitute for the ROOT
	SELECT 
        R.ACCOUNTID
        ,R.IGL_NUMBER
        ,R.IGL_SUBSTITUTEFORID
        ,NS.ACCOUNTID AS NS_ACCOUNT_ID
        ,NS.IGL_NUMBER AS NS_IGL_NUMBER
        ,NS.IGL_NEODATE AS NS_OPEN_DT
        ,NS.IGL_CLOSINGDATE AS NS_CLOSE_DT
        
    FROM STORES R -- root store
        JOIN STORES NS -- next store 
			ON R.ACCOUNTID = NS.IGL_SUBSTITUTEFORID
)
, RECUR AS 
(
    -- root stores
    SELECT 
        *
        ,1 AS LEVEL
	FROM RECUR_BASE R
    WHERE 1=1
        AND R.ACCOUNTID NOT IN (SELECT IGL_REPLACEMENTID FROM STORES WHERE IGL_REPLACEMENTID IS NOT NULL)
        AND R.IGL_SUBSTITUTEFORID IS NULL
	
	UNION ALL

    SELECT 
        REC.ACCOUNTID
        ,REC.IGL_NUMBER
        ,REC.IGL_SUBSTITUTEFORID
        ,NS.NS_ACCOUNT_ID AS NS_ACCOUNT_ID
        ,NS.NS_IGL_NUMBER AS NS_IGL_NUMBER
        ,NS.NS_OPEN_DT AS NS_OPEN_DT
        ,NS.NS_CLOSE_DT AS NS_CLOSE_DT
        ,REC.LEVEL + 1           AS LEVEL
    FROM RECUR REC
        JOIN RECUR_BASE NS ON REC.NS_ACCOUNT_ID = NS.ACCOUNTID
)
--- in case we get info for the successor both via igl_replacementid and igl_substituteforid we want to avoid the creation of duplicate key
SELECT DISTINCT
        KEYS.PARTY_SID, -- Original Store SID
        KEYS.PARTY_KEY_TYPE_CD,
        SUBSTR(R.NS_IGL_NUMBER,1,2)||'|'||TO_NUMBER(SUBSTR(R.NS_IGL_NUMBER,3)) AS CURR_STORE_NK, -- Descendent Store NK
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        '9999-12-31 23:59:59',
        TRUE,
        'LISY',
        '722569' AS DWH_LOAD_ID 
FROM RECUR R
INNER JOIN META.T_PARTY_KEY_2 KEYS 
        ON KEYS.PARTY_NAT_KEY_NR = SUBSTR(R.IGL_NUMBER,1,2)||'|'||TO_NUMBER(SUBSTR(R.IGL_NUMBER,3)) -- Original Store NK
    AND PARTY_KEY_TYPE_CD = 'STORE'
    AND DWH_VALID_FG = 'TRUE'
AND CURR_STORE_NK NOT IN 
        (
            SELECT PARTY_NAT_KEY_NR
            FROM META.T_PARTY_KEY_2
            WHERE PARTY_KEY_TYPE_CD = 'STORE'
            AND CURRENT_TIMESTAMP BETWEEN DWH_VALID_FROM_TMSP AND DWH_VALID_TO_TMSP 
        )
)
;
