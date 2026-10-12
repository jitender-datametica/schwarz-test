delete 
from etl.manual_s_file_article_1;

INSERT INTO  etl.manual_s_file_article_1
                     (       ITEM_SID
                                ,ITEM_GTIN
                                ,LOB_CD
                                ,MANUFACTURER_SID
                                ,UNITSIZE_DESCR
                                ,ITEM_NAME
                                ,ITEM_CONTAINER_TYPE_CD
                                ,ITEM_PACKAGE_TYPE_DESCR
                                ,FIRST_DISTRIBUTOR_NAME
                                ,COUNTRY_POL_CD
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP
                                ,DWH_SRC_FILE_NAME
                                ,SRC_1_TMSP
                                ,SRC_2_TMSP
                                ,SRC_3_TMSP
                      )

SELECT                      ITEM_SID
                                ,ITEM_GTIN
                                ,LOB_CD
                                ,MANUFACTURER_SID
                                ,UNITSIZE_DESCR
                                ,ITEM_NAME
                                ,ITEM_CONTAINER_TYPE_CD
                                ,ITEM_PACKAGE_TYPE_DESCR
                                ,FIRST_DISTRIBUTOR_NAME
                                ,COUNTRY_POL_CD
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP
                                ,DWH_SRC_FILE_NAME
                                ,SRC_1_TMSP
                                ,SRC_2_TMSP
                                ,SRC_3_TMSP

FROM ETL.manual_s_file_article_temp
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
