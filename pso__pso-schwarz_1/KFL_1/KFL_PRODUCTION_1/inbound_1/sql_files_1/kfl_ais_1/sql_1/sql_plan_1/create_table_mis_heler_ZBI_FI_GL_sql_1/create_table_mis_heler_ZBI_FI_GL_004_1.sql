--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE or REPLACE TABLE DBP_ETL.mis_heler_1  (
 comp_code      VARCHAR( 4)
,gl_account     VARCHAR(10)
,alloc_nmbr     VARCHAR(18)
,fiscyear       SMALLINT
,fiscper3       SMALLINT
,ac_doc_no      VARCHAR(10)
,item_num       SMALLINT
,deb_cre_lc     DECIMAL(18,2) DEFAULT 0.00
,loc_currcy     VARCHAR( 5)
,dcindic        VARCHAR( 1)
,accdoctype     VARCHAR( 5)
,doc_date       VARCHAR( 8)
,pstng_date     VARCHAR( 8)
,bus_area       VARCHAR( 4)
,plant          VARCHAR( 4)
,profit_ctr     VARCHAR(10)
,costcenter     VARCHAR(10)
)
;

