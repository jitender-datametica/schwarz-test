delete 
from CORE.t_dim_deposit_item_2;

INSERT INTO  CORE.t_dim_deposit_item_2
                     (       ITEM_GRP_NR
                             ,DEPOSIT_ITEM_NAME
                             ,EAN_2
                             ,DEPOSIT_ITEM_CAT_CD
                             ,RVM_MANUFACTURER_SID
                             ,LOB_CD
                             ,COUNTRY_POL_CD
                             ,ITEM_CONTENT_CL_QTY
                             ,ITEM_MATERIAL_NAME
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP
                             ,ITEM_REFUND
                      )

SELECT                      ITEM_GRP_NR
                             ,DEPOSIT_ITEM_NAME
                             ,EAN_2
                             ,DEPOSIT_ITEM_CAT_CD
                             ,RVM_MANUFACTURER_SID
                             ,LOB_CD
                             ,COUNTRY_POL_CD
                             ,ITEM_CONTENT_CL_QTY
                             ,ITEM_MATERIAL_NAME
                             ,DWH_CREATED_TMSP
                             ,DWH_UPDATED_TMSP
                             ,ITEM_REFUND

FROM ETL.t_dim_deposit_item_temp_2
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
