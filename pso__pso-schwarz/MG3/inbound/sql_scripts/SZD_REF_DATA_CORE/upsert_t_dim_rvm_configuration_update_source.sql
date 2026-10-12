delete 
from CORE.t_dim_rvm_configuration_update_source;

INSERT INTO  CORE.t_dim_rvm_configuration_update_source 
                     (       RVM_CONFIG_SOURCE_CD
                            ,RVM_CONFIG_SOURCE_DESCR
                            ,RVM_CONFIG_SOURCE_DESCR_EN
                            ,RVM_CONFIG_SOURCE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
                      )

SELECT                      RVM_CONFIG_SOURCE_CD
                            ,RVM_CONFIG_SOURCE_DESCR
                            ,RVM_CONFIG_SOURCE_DESCR_EN
                            ,RVM_CONFIG_SOURCE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP

FROM ETL.t_dim_rvm_configuration_update_source_temp
--WHERE MANUFACTURER_SID IS NOT NULL
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
