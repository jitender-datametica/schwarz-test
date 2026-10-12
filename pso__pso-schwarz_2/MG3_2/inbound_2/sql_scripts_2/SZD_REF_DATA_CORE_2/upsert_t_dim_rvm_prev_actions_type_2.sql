delete 
from CORE.t_dim_rvm_prev_actions_type_2;

INSERT INTO  CORE.t_dim_rvm_prev_actions_type_2
                     (       RVM_PREV_ACTION_TYPE_ID
                             ,RVM_PREV_ACTION_TYPE_DESCR
                             ,RVM_PREV_ACTION_TYPE_DESCR_EN
                             ,RVM_PREV_ACTION_TYPE_DESCR_DE
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP

                      )

SELECT                      RVM_PREV_ACTION_TYPE_ID
                             ,RVM_PREV_ACTION_TYPE_DESCR
                             ,RVM_PREV_ACTION_TYPE_DESCR_EN
                             ,RVM_PREV_ACTION_TYPE_DESCR_DE
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP


FROM ETL.t_dim_rvm_prev_actions_type_temp_2
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
