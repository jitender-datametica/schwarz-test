
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AUL_ITM_ART_TYPE_MTH_PY_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
      /* 
      #DescStart# 
      #$Revision: 6244 $, $LastChangedBy: hwieber $ 
      #SubjectAreas#: AUL 
      #DescEnd# 
      */
      SELECT
      itm.client_id,
      itm.item_sid AS item_id,
      m.cy_month,
      itm.buying_list_type_id,
      itm.buying_list_type_desc,
      itm2.buying_list_type_id   AS buying_list_type_id_py,
      itm2.buying_list_type_desc AS buying_list_type_desc_py
      FROM p_lew_core_ac.v_wawi_itm_item_2 AS itm
      CROSS JOIN p_lew_core_ac.v_wawi_cal_month_2 AS m
      LEFT JOIN p_lew_core_ac.v_wawi_itm_item_2 AS itm2
      ON  itm.client_id = itm2.client_id
      AND    itm.item_sid  =  itm2.item_sid
      AND ADD_MONTHS(TO_DATE(cy_month || 01,'YYYYMMDD'), 1 - 12) -1 BETWEEN itm2.dat_rec_start AND itm2.dat_rec_end 
      WHERE ADD_MONTHS(TO_DATE(cy_month || 01,'YYYYMMDD') , 1   ) -1 BETWEEN  itm.dat_rec_start AND  itm.dat_rec_end 
        AND m.cy_month_sequence <= 0;
