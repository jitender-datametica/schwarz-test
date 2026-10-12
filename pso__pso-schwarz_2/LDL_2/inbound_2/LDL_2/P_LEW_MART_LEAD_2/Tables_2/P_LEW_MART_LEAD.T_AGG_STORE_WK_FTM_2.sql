CREATE TABLE P_LEW_MART_LEAD.T_AGG_STORE_WK_FTM_2
(	
    CLIENT_ID	            NUMBER(38,0) NOT NULL COMMENT 'Client identifier',
    CY_WEEK	                NUMBER(38,0) COMMENT 'Week',
    CY_WEEK_SEQUENCE	    NUMBER(38,0) COMMENT 'Week Sequence',
    ORIG_STORE_NR	        NUMBER(38,0) NOT NULL COMMENT 'Store number',
    LOC_SID_STORE_MOVE_TO   NUMBER(38,0) NOT NULL COMMENT 'Store id',
    COUNTRY_CD	            VARCHAR(3)   NOT NULL COMMENT 'Country_2 code',
    COUNTRY_STORE_WEEK	    VARCHAR(100) COMMENT 'Country_2, Store, Week list',
    REF_CY_WEEK	            NUMBER(38,0) COMMENT 'Reference Week',
    
    SALES_NET_VAL	        NUMBER(38,5),
    SALES_PIECES	        NUMBER(38,5),
    WRTOFF_VAL	            NUMBER(38,5),
    BUYING_VAL	            NUMBER(38,5),
    REF_SALES_NET_VAL	    NUMBER(38,5),
    REF_SALES_PIECES	    NUMBER(38,5),
    REF_WRTOFF_VAL	        NUMBER(38,5),
    REF_BUYING_VAL	        NUMBER(38,5)
) COMMENT = 'FTM Aggregate Store Week table'
;