delete 
from CORE.t_dim_rvm_pack_type_1;

INSERT INTO  CORE.t_dim_rvm_pack_type_1 
                     (       RVM_PACK_TYPE_CD
                            ,RVM_PACK_TYPE_DESCR_EN
                            ,RVM_PACK_TYPE_DESCR
                            ,RVM_PACK_TYPE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
                      )

SELECT                      RVM_PACK_TYPE_CD
                            ,RVM_PACK_TYPE_DESCR_EN
                            ,RVM_PACK_TYPE_DESCR
                            ,RVM_PACK_TYPE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP

FROM ETL.t_dim_rvm_pack_type_temp
--WHERE MANUFACTURER_SID IS NOT NULL
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
