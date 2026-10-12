delete 
from CORE.t_dim_rvm_sort_type;

INSERT INTO  CORE.t_dim_rvm_sort_type 
                     (       RVM_SORT_TYPE_CD
                            ,RVM_SORT_TYPE_DESCR
                            ,RVM_SORT_TYPE_DESCR_EN
                            ,RVM_SORT_TYPE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
                      )

SELECT                      RVM_SORT_TYPE_CD
                            ,RVM_SORT_TYPE_DESCR
                            ,RVM_SORT_TYPE_DESCR_EN
                            ,RVM_SORT_TYPE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP

FROM ETL.t_dim_rvm_sort_type_temp
--WHERE MANUFACTURER_SID IS NOT NULL
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
