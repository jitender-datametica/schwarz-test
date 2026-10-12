/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: T_REF_SEGMENT_BIS_QTR
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-06-01 Marcin Kikola    Initial version AP0092849_neue_kundencluster
#  1.1 2022-08-04 Pawel Wieczorek  AP0092849 changing names
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_rf_segment_busyear_qtr_2 (
busyear_qtr_rf_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ids of recency-frequency segments from rfm model - used (BUSYEAR_QTR_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid'),
busyear_qtr_rf_segment_name STRING(100) NOT NULL
OPTIONS(description='Recency-frequency segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special'),
busyear_qtr_rf_segment_descr STRING(250) OPTIONS(description='Exact description of recency-frequency from rfm model'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (busyear_qtr_rf_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : Recency-frequency segments - referenece table - Business year quarter');