/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI.V_REF_CUSTOMER_COMPLAINT_ORIGIN
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_customer_complaint_origin AS SELECT *
FROM ldl_p_lew_core_ac.v_ref_customer_complaint_origin;