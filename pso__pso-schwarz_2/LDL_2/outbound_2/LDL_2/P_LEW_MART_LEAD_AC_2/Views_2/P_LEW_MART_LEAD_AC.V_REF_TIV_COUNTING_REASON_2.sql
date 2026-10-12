/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_REF_TIV_COUNTING_REASON_2
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_tiv_counting_reason_2 (cnt_reason_id
OPTIONS(description='ID DER BEGRÜNDUNG DER INVENTURZÄHLUNG'), cnt_reason_descr
OPTIONS(description='BEGRÜNDUNG DER INVENTURZÄHLUNG'), cnt_reason_descr_en
OPTIONS(description='BEGRÜNDUNG DER INVENTURZÄHLUNG - ENGLISCH'))
OPTIONS(DESCRIPTION = `TIV - BEGRÜNDUNG ZUM ZÄHLERAUFTRAG`) AS SELECT cnt_reason_id,
 cnt_reason_descr,
 cnt_reason_descr_en
FROM ldl_p_lew_core.t_ref_counting_reason_2;