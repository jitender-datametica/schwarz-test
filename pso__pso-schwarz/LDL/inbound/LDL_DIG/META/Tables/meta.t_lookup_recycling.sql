CREATE TABLE META.T_LOOKUP_RECYCLING(
    CUST_ORDER_TYPE_CD                           VARCHAR(20),	
    SALESORG                                     VARCHAR(20),	
    SALES_SEGMENT_TYPE_CD                        VARCHAR(20),	
    CUST_NR	                                     VARCHAR(20), 
    STORAGE_LOC_CD                               VARCHAR(20),	
    BATCH_NR                                     VARCHAR(20),  
    MATERIAL_DOC_MOV_TYPE_CD                     VARCHAR(20),  
    MATERIAL_DOC_MOV_PROCESS_SUBTYPE_NAME        VARCHAR(100), 
    IS_RECYCLING_FG                              BOOLEAN,
    SOURCE                                       VARCHAR(20),
    VALID_FROM_DT                                DATE,
    VALID_TO_DT                                  DATE, 
	TMSP_INSERT                                  TIMESTAMP_LTZ(9),
	TMSP_UPDATE                                  TIMESTAMP_LTZ(9)
);