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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_cust_rfm_segment_busyear_qtr (geo_area_sid
OPTIONS(description='Identifier for a client'), busyear_qtr OPTIONS(description='Business year quarter identifier'),
model_sid OPTIONS(description='ID of a rfm model'), busyear_qtr_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), busyear_qtr_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), customer_sid
OPTIONS(description='Surrogate Key CUSTOMER'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : BUSINESS YEAR QUARTER LEVEL OF RECENCY-FREQUENCY AND MONETARY SEGMENTS PER CUSTOMER`)
AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_cust_rfm_segment_busyear_qtr;