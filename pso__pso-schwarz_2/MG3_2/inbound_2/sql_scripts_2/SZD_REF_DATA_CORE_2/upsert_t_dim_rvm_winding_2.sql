delete 
from CORE.t_dim_rvm_winding_2;

INSERT INTO  CORE.t_dim_rvm_winding_2 
                     (       RVM_WINDING_CD
                            ,RVM_WINDING_DESCR
                            ,RVM_WINDING_DESCR_DE
                            ,RVM_WINDING_DESCR_EN
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
                      )

SELECT                      RVM_WINDING_CD
                            ,RVM_WINDING_DESCR
                            ,RVM_WINDING_DESCR_DE
                            ,RVM_WINDING_DESCR_EN
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP

FROM ETL.t_dim_rvm_winding_temp_2
--WHERE MANUFACTURER_SID IS NOT NULL
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
