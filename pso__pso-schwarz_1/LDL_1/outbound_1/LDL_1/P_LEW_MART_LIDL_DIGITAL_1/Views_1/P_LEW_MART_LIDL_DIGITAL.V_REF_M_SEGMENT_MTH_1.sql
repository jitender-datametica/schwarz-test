/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: V_REF_MONETARY_MTH
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-03-30 Marcin Kikola    Initial version AP0092849_neue_kundencluster
#  1.1 2022-08-05 Pawel Wieczorek  AP0092849 changing names
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_m_segment_mth_1 (mth_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), mth_m_segment_name
OPTIONS(description='monetary segments, m_segment: high, medium, low'), mth_m_segment_descr
OPTIONS(description='exact description of monetary segments from rfm model'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : MONETARY SEGMENTS - REFERENECE TABLE`) AS
SELECT mth_m_segment_sid,
 mth_m_segment_name,
 mth_m_segment_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_m_segment_mth_1;