/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: V_REF_SEGMENT_WK
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
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_rf_segment_wk_1 (wk_rf_segment_sid
OPTIONS(description='Ids of recency-frequency segments from rfm model'), wk_rf_segment_name
OPTIONS(description='Recency-frequency segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special'),
wk_rf_segment_descr OPTIONS(description='Exact description of recency-frequency from rfm model'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : RECENCY-FREQUENCY SEGMENTS - REFERENECE TABLE`) AS SELECT wk_rf_segment_sid,
 wk_rf_segment_name,
 wk_rf_segment_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_rf_segment_wk_1;