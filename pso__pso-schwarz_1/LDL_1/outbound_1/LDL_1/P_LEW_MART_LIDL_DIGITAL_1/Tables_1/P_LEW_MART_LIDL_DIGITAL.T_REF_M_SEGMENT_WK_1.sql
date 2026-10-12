/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: T_REF_MONETARY_WK
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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_m_segment_wk_1 (
wk_m_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
wk_m_segment_name STRING(100) NOT NULL OPTIONS(description='monetary segments, m_segment: high, medium, low'),
wk_m_segment_descr STRING(250) OPTIONS(description='exact description of monetary segments from rfm model'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (wk_m_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : monetary segments - referenece table');