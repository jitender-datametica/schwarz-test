delete 
from CORE.t_dim_deposit_outpayment_type;

INSERT INTO  CORE.t_dim_deposit_outpayment_type
                     (          DEPOSIT_OUTPAYMENT_TYPE_CD
                                ,DEPOSIT_OUTPAYMENT_TYPE_DESCR
                                ,DEPOSIT_OUTPAYMENT_TYPE_DESCR_EN
                                ,DEPOSIT_OUTPAYMENT_TYPE_DESCR_DE
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP

                      )

SELECT                          DEPOSIT_OUTPAYMENT_TYPE_CD
                                ,DEPOSIT_OUTPAYMENT_TYPE_DESCR
                                ,DEPOSIT_OUTPAYMENT_TYPE_DESCR_EN
                                ,DEPOSIT_OUTPAYMENT_TYPE_DESCR_DE
                                ,DWH_CREATED_TMSP
                                ,DWH_UPDATED_TMSP


FROM ETL.t_dim_deposit_outpayment_type_temp
--QUALIFY ROW_NUMBER() OVER (PARTITION BY MANUFACTURER_SID ORDER BY  DWH_CREATED_TMSP DESC) = 1
;
                                                                                     


COMMIT;
