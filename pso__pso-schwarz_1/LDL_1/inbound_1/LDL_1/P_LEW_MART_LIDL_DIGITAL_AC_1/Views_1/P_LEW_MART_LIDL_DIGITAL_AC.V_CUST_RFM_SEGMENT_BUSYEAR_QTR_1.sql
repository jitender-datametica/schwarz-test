/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: V_CUST_SEGMENT_MONETARY_WK
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-08-05 Pawel Wieczorek  AP0092849 changing names
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   View DDL
   ============================================================================== */
CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_CUST_RFM_SEGMENT_BUSYEAR_QTR_1
COMMENT = 'Lidlplus : business year quarter level of recency-frequency and monetary segments per customer'
(
 GEO_AREA_SID                 COMMENT 'Identifier for a client'
,BUSYEAR_QTR                  COMMENT 'Business year quarter identifier'
,MODEL_SID                    COMMENT 'ID of a rfm model'
,BUSYEAR_QTR_M_SEGMENT_SID    COMMENT 'ids of monetary segments from rfm model'
,BUSYEAR_QTR_RF_SEGMENT_SID   COMMENT 'ids of recency-frequency segments from rfm model'
,CUSTOMER_SID                 COMMENT 'Surrogate Key CUSTOMER'
,LOAD_ID                      COMMENT 'Load identifier'
,DWH_CREATED                  COMMENT 'Row create time'
,DWH_UPDATED                  COMMENT 'Row update time'
)
AS
SELECT
 GEO_AREA_SID
,BUSYEAR_QTR
,MODEL_SID
,BUSYEAR_QTR_M_SEGMENT_SID
,BUSYEAR_QTR_RF_SEGMENT_SID
,CUSTOMER_SID
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_CUST_RFM_SEGMENT_BUSYEAR_QTR_1 
;