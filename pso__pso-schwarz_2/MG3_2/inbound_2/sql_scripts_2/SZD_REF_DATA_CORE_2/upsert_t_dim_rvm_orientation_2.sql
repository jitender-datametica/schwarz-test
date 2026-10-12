delete 
from CORE.t_dim_rvm_orientation_2;

INSERT INTO  CORE.t_dim_rvm_orientation_2 
                     (       RVM_ORIENTATION_CD
                            ,RVM_ORIENTATION_DESCR_EN
                            ,RVM_ORIENTATION_DESCR
                            ,RVM_ORIENTATION_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
                      )

SELECT                      RVM_ORIENTATION_CD
                            ,RVM_ORIENTATION_DESCR_EN
                            ,RVM_ORIENTATION_DESCR
                            ,RVM_ORIENTATION_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP

FROM ETL.t_dim_rvm_orientation_temp
--WHERE MANUFACTURER_SID IS NOT NULL
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
