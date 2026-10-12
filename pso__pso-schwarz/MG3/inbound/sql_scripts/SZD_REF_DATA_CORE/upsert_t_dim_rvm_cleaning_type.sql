delete 
from CORE.t_dim_rvm_cleaning_type;

INSERT INTO  CORE.t_dim_rvm_cleaning_type
                     (       CLEANING_TYPE_CD
                             ,CLEANING_TYPE_DESCR
                             ,CLEANING_TYPE_DESCR_EN
                             ,CLEANING_TYPE_DESCR_DE
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP

                      )

SELECT                      CLEANING_TYPE_CD
                             ,CLEANING_TYPE_DESCR
                             ,CLEANING_TYPE_DESCR_EN
                             ,CLEANING_TYPE_DESCR_DE
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP

FROM ETL.t_dim_rvm_cleaning_type_temp
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
