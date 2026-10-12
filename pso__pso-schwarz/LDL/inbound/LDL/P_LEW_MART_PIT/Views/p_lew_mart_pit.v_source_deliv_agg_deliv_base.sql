/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_DELIV_AGG_DELIV_BASE
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_DELIV_AGG_DELIV_BASE
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-13 Massimo Morelli     Initial version
#  1.1  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.2  2021-10-13 Massimo Morelli	   Added delivery type, requested for business rule
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_DELIV_AGG_DELIV_BASE
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_DELIV_AGG_DELIV_BASE
COMMENT = 'V_SOURCE_DELIV_AGG_DELIV_BASE'
AS
SELECT

      deliv.client_id::INTEGER                          AS CLIENT_ID
    , deliv.item_sid::INTEGER                           AS ITEM_SID
    , deliv.dat_formdate::DATE                          AS DAT_FORMDATE
    , deliv.loc_sid_store::INTEGER                      AS STORE_SID
    
    , deliv.qty_total_del::NUMBER(38,5)                 AS ITEM_DELIVERY_TO_STORE_QTY
    , deliv.deliverytype_id::INTEGER                    AS DELIVERYTYPE_ID

    , TO_DATE('1900-01-01','YYYY-MM-DD')              AS VALID_FROM_DT
    , TO_DATE('9999-12-31','YYYY-MM-DD')              AS VALID_TO_DT
    , 0::SMALLINT                                     AS DELETED_FG
    , deliv.DWH_UPDATED::TIMESTAMP                      AS DWH_UPDATED_TS

FROM
	(
       SELECT
              CLIENT_ID
			, ITEM_SID
			, DAT_FORMDATE
			, LOC_SID_STORE		
			, QTY_TOTAL_DEL
			, DELIVERYTYPE_ID
			, DWH_UPDATED
        FROM P_LEW_BIL.T_AGG_DELIV_BASE -- P_LEW_CORE.T_ITEM_DELIVERY
		WHERE TRUE
			AND CLIENT_ID IN (
				-- PIT Country
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)		
        -- no deduplication because of high row count
	) deliv
           
WHERE TRUE
;