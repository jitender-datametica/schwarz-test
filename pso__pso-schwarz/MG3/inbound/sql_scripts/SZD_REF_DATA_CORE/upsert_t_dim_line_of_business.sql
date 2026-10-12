delete 
from CORE.t_dim_line_of_business;

INSERT INTO  CORE.t_dim_line_of_business
                     (       LOB_CD
                             ,LOB_NAME
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP


                      )

SELECT                      LOB_CD
                             ,LOB_NAME
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP


FROM ETL.t_dim_line_of_business_temp
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
