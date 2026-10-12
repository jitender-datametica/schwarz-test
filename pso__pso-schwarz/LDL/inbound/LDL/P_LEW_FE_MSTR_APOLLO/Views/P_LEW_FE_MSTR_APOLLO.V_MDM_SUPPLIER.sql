/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_SUPPLIER
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_SUPPLIER  
(
	client_id
    ,mdm_sup_sid
	,src_vendor_doc_ref
	,sup_nr
	,sup_name
	,dwh_load_id
	,dwh_created
	,dwh_updated     
)
AS
    SELECT 
    client_id
    ,mdm_sup_sid
	,src_vendor_doc_ref
	,sup_nr
	,sup_name
	,dwh_load_id
	,dwh_created
	,dwh_updated     

FROM P_LEW_CORE_AC.V_MDM_SUPPLIER  ;