/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_REF_TIV_INV_TYPE
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_tiv_inv_type (inv_type_id OPTIONS(description='INVENTURTYPE ID'),
inv_type_descr OPTIONS(description='BESCHREIBUNG DES INVENTURTYPS'), inv_type_descr_en
OPTIONS(description='BESCHREIBUNG DES INVENTURTYPS - ENGLISCH')) OPTIONS(DESCRIPTION = `TIV - INVENTURTYPEN`) AS SELECT
 inv_type_id,
 inv_type_descr,
 inv_type_descr_en
FROM ldl_p_lew_core.t_ref_inv_type;