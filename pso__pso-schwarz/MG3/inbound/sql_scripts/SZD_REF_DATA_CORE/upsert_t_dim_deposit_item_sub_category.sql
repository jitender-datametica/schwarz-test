delete 
from CORE.t_dim_deposit_item_sub_category;

INSERT INTO  CORE.t_dim_deposit_item_sub_category
                     (          DEPOSIT_ITEM_SUB_CAT_ID
                                ,DEPOSIT_ITEM_CAT_CD
                                ,DEPOSIT_ITEM_SUB_CAT_DESCR
                                ,DEPOSIT_ITEM_SUB_CAT_DESCR_DE
                                ,DEPOSIT_ITEM_SUB_CAT_DESCR_EN
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP

                      )

SELECT                      DEPOSIT_ITEM_SUB_CAT_ID
                                ,DEPOSIT_ITEM_CAT_CD
                                ,DEPOSIT_ITEM_SUB_CAT_DESCR
                                ,DEPOSIT_ITEM_SUB_CAT_DESCR_DE
                                ,DEPOSIT_ITEM_SUB_CAT_DESCR_EN
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP


FROM ETL.t_dim_deposit_item_sub_category_temp
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
