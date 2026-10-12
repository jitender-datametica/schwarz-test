delete 
from CORE.t_dim_rvm_type_1;

INSERT INTO  CORE.t_dim_rvm_type_1 
                     (       RVM_TYPE_CD
                            ,MANUFACTURER_SID
                            ,RVM_TYPE_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
                      )

SELECT                      RVM_TYPE_CD
                            ,MANUFACTURER_SID
                            ,RVM_TYPE_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP

FROM ETL.t_dim_rvm_type_temp
--WHERE MANUFACTURER_SID IS NOT NULL
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
