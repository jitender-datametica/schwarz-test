CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_POS_STORE_ITEM_DAY_RETURN_2 as
	
   SELECT	
     rtn.client_id,	
   rtn.loc_sid       AS loc_sid_store,	
   rtn.item_sid,	
   rtn.dwh_cal_dt    AS  dwh_cal_dt,	
   Sum(CASE WHEN rtn.transaction_type_cd BETWEEN '140' AND '149'	
             THEN (CASE WHEN rtn.weight_item_fg <> 1	
                        THEN ZeroIfNull(rtn.sales_piece_qty)	
                        ELSE ZeroIfNull(rtn.sales_weight_qty)	
                   END)	
             WHEN rtn.transaction_type_cd BETWEEN '440' AND '449'	
             THEN ZeroIfNull(rtn.discount_weight_qty)	
             WHEN rtn.transaction_type_cd BETWEEN '640' AND '649'	
             THEN ZeroIfNull(rtn.discount_piece_qty)  ELSE 0  END)     AS return_qty,	
   rtn.return_reason_cd  AS return_reason_cd,	
   CURRENT_TIMESTAMP(6)  AS dwh_updated	
    FROM p_lew_core_ac.v_pos_receiptline_2  AS rtn	
   WHERE  rtn.transaction_type_cd IN ('140','141','142','143','144','145','146','147','148','149'	
                                   ,'440','441','442','443','444','445','446','447','448','449'	
                                   ,'640','641','642','643','644','645','646','647','648','649')	
	
    AND rtn.dwh_cal_dt  >= '1111-01-01'	
    AND rtn.client_id <=42	
	
   GROUP BY	
   rtn.client_id	
 , rtn.loc_sid	
 , rtn.item_sid	
 , rtn.dwh_cal_dt	
 , rtn.return_reason_cd	
	
;