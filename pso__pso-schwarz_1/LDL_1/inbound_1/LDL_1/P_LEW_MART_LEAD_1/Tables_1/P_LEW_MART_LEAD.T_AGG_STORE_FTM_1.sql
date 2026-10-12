CREATE TABLE P_LEW_MART_LEAD.T_AGG_STORE_FTM_1
(	
    CLIENT_ID	                  NUMBER(38,0) NOT NULL COMMENT 'Client identifier',
    ORIG_STORE_NR	              NUMBER(38,0) NOT NULL COMMENT 'Store number',
    LOC_SID_STORE_MOVE_TO         NUMBER(38,0) NOT NULL COMMENT 'Store id',
    COUNTRY_CD	                  VARCHAR(3)   NOT NULL COMMENT 'Country_1 code',
    COUNTRY_STORE_WEEK	          VARCHAR(100) COMMENT 'Country_1, Store, Week list',
    REF_CY_WEEK	                  NUMBER(38,0) COMMENT 'Reference Week',
                                  
    SALES_NET_VAL	              NUMBER(38,5),
    SALES_PIECES	              NUMBER(38,5),
    WRTOFF_VAL	                  NUMBER(38,5),
    BUYING_VAL	                  NUMBER(38,5),
    REF_SALES_NET_VAL	          NUMBER(38,5),
    REF_SALES_PIECES	          NUMBER(38,5),
    REF_WRTOFF_VAL	              NUMBER(38,5),
    REF_BUYING_VAL	              NUMBER(38,5),

    WRTOFF_ABSOLUTE_VAL           NUMBER(38,5),
    REF_WRTOFF_ABSOLUTE_VAL       NUMBER(38,5),
    MARGIN_SALES_ABSOLUTE_VAL     NUMBER(38,5),
    REF_MARGIN_SALES_ABSOLUTE_VAL NUMBER(38,5),

    MARGIN_SALES_NET_VAL	      NUMBER(38,5),
    MARGIN_SALES_PIECES	          NUMBER(38,5),
    MARGIN_WRTOFF_VAL	          NUMBER(38,5),
    MARGIN_BUYING_VAL	          NUMBER(38,5),
                                  
    DIFF_SALES_NET_VAL	          NUMBER(38,5),
    DIFF_SALES_PIECES	          NUMBER(38,5),
    DIFF_WRTOFF_VAL	              NUMBER(38,5),
    DIFF_BUYING_VAL	              NUMBER(38,5),
                                  
    MEAN_SALES_NET_VAL	          NUMBER(38,5),
    MEAN_SALES_PIECES	          NUMBER(38,5),
    MEAN_WRTOFF_VAL	              NUMBER(38,5),
    MEAN_BUYING_VAL	              NUMBER(38,5),
                                  
    STDEV_SALES_NET_VAL	          NUMBER(38,5),
    STDEV_SALES_PIECES 	          NUMBER(38,5),
    STDEV_WRTOFF_VAL	          NUMBER(38,5),
    STDEV_BUYING_VAL	          NUMBER(38,5),
                                  
    REF_MEAN_SALES_NET_VAL_PCT	  NUMBER(38,5),
    REF_MEAN_SALES_PIECES_PCT	  NUMBER(38,5),
    REF_MEAN_WRTOFF_VAL_PCT		  NUMBER(38,5),
    REF_MEAN_BUYING_VAL_PCT		  NUMBER(38,5),
                                  
    REF_STDEV_SALES_NET_VAL_PCT	  NUMBER(38,5),
    REF_STDEV_SALES_PIECES_PCT	  NUMBER(38,5),
    REF_STDEV_WRTOFF_VAL_PCT	  NUMBER(38,5),
    REF_STDEV_BUYING_VAL_PCT	  NUMBER(38,5),
                                  
    MIN_SALES_NET_VAL_PCT	      NUMBER(38,5),
    MAX_SALES_NET_VAL_PCT	      NUMBER(38,5),
    MIN_SALES_PIECES_PCT	      NUMBER(38,5),
    MAX_SALES_PIECES_PCT	      NUMBER(38,5),
    MIN_WRTOFF_VAL_PCT	          NUMBER(38,5),
    MAX_WRTOFF_VAL_PCT	          NUMBER(38,5),
    MIN_BUYING_VAL_PCT	          NUMBER(38,5),
    MAX_BUYING_VAL_PCT	          NUMBER(38,5),
                                  
    MIN_SALES_NET_VAL_ABS	      NUMBER(38,5),
    MAX_SALES_NET_VAL_ABS	      NUMBER(38,5),
    MIN_SALES_PIECES_ABS	      NUMBER(38,5),
    MAX_SALES_PIECES_ABS	      NUMBER(38,5),
    MIN_WRTOFF_VAL_ABS	          NUMBER(38,5),
    MAX_WRTOFF_VAL_ABS	          NUMBER(38,5),
    MIN_BUYING_VAL_ABS	          NUMBER(38,5),
    MAX_BUYING_VAL_ABS	          NUMBER(38,5)
) COMMENT = 'FTM Aggregate Store table'
;