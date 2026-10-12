delete 
from CORE.t_dim_rvm_cleaning_status_2;

INSERT INTO  CORE.t_dim_rvm_cleaning_status_2
                     (       CLEANING_STATUS_CD
                             ,CLEANING_STATUS_DESCR
                             ,CLEANING_STATUS_DESCR_EN
                             ,CLEANING_STATUS_DESCR_DE
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP

                      )

SELECT                      CLEANING_STATUS_CD
                             ,CLEANING_STATUS_DESCR
                             ,CLEANING_STATUS_DESCR_EN
                             ,CLEANING_STATUS_DESCR_DE
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP


FROM ETL.t_dim_rvm_cleaning_status_temp_2
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
