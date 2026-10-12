delete 
from CORE.t_dim_rvm_rejection_reason_1;

INSERT INTO  CORE.t_dim_rvm_rejection_reason_1
                     (          REJECT_REASON_ID
                                ,DEPOSIT_ITEM_CAT_CD
                                ,REJECT_REASON_GROUP_ID
                                ,REJECT_REASON_DESCR
                                ,REJECT_REASON_DESCR_EN
                                ,REJECT_REASON_DESCR_DE
                                ,REJECT_REASON_SOURCE_NR
                                ,REJECT_REASON_SOURCE_NAME
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP


                      )

SELECT                          REJECT_REASON_ID
                                ,DEPOSIT_ITEM_CAT_CD
                                ,REJECT_REASON_GROUP_ID
                                ,REJECT_REASON_DESCR
                                ,REJECT_REASON_DESCR_EN
                                ,REJECT_REASON_DESCR_DE
                                ,REJECT_REASON_SOURCE_NR
                                ,REJECT_REASON_SOURCE_NAME
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP


FROM ETL.t_dim_rvm_rejection_reason_temp_1
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
