/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: T_REF_RF_SEGMENT_WK
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-03-30 Marcin Kikola    Initial version AP0092849_neue_kundencluster
#  1.1 2022-08-04 Pawel Wieczorek  AP0092849 changing names
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_rf_segment_wk (
wk_rf_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ids of recency-frequency segments from rfm model - used (WK_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid'),
wk_rf_segment_name STRING(100) NOT NULL
OPTIONS(description='Recency-frequency segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special'),
wk_rf_segment_descr STRING(250) OPTIONS(description='Exact description of recency-frequency from rfm model'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (wk_rf_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : Recency-frequency segments - referenece table');