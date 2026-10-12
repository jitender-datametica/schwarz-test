delete 
from CORE.t_dim_manufacturer_group_1;

INSERT INTO  CORE.t_dim_manufacturer_group_1 
                     (       MANUFACTURER_GROUP_CD
                            ,MANUFACTURER_GROUP_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
                      )

SELECT                      MANUFACTURER_GROUP_CD
                            ,MANUFACTURER_GROUP_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP

FROM ETL.t_dim_manufacturer_group_temp
--WHERE MANUFACTURER_SID IS NOT NULL
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
