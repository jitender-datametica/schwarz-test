CREATE TABLE P_LEW_MART_LEAD.T_AGG_STORE_WK_SIG_FTM
(	
    CLIENT_ID	            NUMBER(38,0) NOT NULL COMMENT 'Client identifier',
    CY_WEEK	                NUMBER(38,0) COMMENT 'Week',   
    CY_WEEK_SEQUENCE	    NUMBER(38,0) COMMENT 'Week Sequence',       
    ORIG_STORE_NR	        NUMBER(38,0) COMMENT 'Store number',
    LOC_SID_STORE_MOVE_TO   NUMBER(38,0) COMMENT 'Store id',
    COUNTRY_CD	            VARCHAR(3)   COMMENT 'Country code',
    COUNTRY_STORE_WEEK	    VARCHAR(100) COMMENT 'Country, Store, Week list',
    SUBITEMGROUP_ID	        NUMBER(38,0) COMMENT 'Sub item group number',
    ITEMGROUP_INT_ID	    NUMBER(38,0) COMMENT 'Item group number',
    REF_CY_WEEK	            NUMBER(38,0) COMMENT 'Reference Week',
    REF_ORIG_STORE_NR	    VARCHAR(100) COMMENT 'Reference Store number',
    
    SALES_NET_VAL	        NUMBER(38,5),
    SALES_PIECES	        NUMBER(38,5),
    WRTOFF_VAL	            NUMBER(38,5),
    BUYING_VAL	            NUMBER(38,5),
    REF_SALES_NET_VAL	    NUMBER(38,5),
    REF_SALES_PIECES	    NUMBER(38,5),
    REF_WRTOFF_VAL	        NUMBER(38,5),
    REF_BUYING_VAL	        NUMBER(38,5)
) COMMENT = 'FTM Aggregate Store Week Sub Item Group table'
;