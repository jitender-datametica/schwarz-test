/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST_1
(
	client_id
	,mdm_item_sid
    ,client_id_order
	,country_del_seq_nr
	,cy_week_delivery
	,country_request_qty
	,country_delivery_qty
	,deleted_fg
	,dwh_valid_from
	,dwh_valid_to
	,dwh_load_id
	,dwh_created
	,dwh_updated      
)
AS
    SELECT 
	client_id
	,mdm_item_sid
    ,client_id_order
	,country_del_seq_nr
	,cy_week_delivery
	,country_request_qty
	,country_delivery_qty
	,deleted_fg
	,dwh_valid_from
	,dwh_valid_to
	,dwh_load_id
	,dwh_created
	,dwh_updated      

FROM P_LEW_CORE_AC.V_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST_1;