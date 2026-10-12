/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: T_CUST_SEGMENT_MONETARY_WK
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-04-04 Marcin Kikola    Initial version AP0092849_neue_kundencluster
#  1.1 2022-08-05 Pawel Wieczorek  AP0092849 changing names
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_cust_rfm_segment_wk (
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for a client'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Week identifier'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of a rfm model'),
wk_m_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
wk_rf_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (model_sid, cy_week, geo_area_sid, customer_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : week level of recency-frequency and monetary segments per customer');