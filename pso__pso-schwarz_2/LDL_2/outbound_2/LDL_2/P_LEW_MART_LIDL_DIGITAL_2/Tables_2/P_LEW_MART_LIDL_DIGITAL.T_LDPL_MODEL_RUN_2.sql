/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: T_MODEL_RUN_2
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-04-04 Marcin Kikola    Initial version AP0092849_neue_kundencluster
#  1.1 2022-07-25 Pawel Wieczorek  Adding column BUSYEAR_QTR
#  1.2 2022-07-26 Pawel Wieczorek  Removing column BUSYEAR_QTR
#  1.3 2022-08-09 Pawel Wieczorek  Changing PK, change encoding, renaming from LAST_RUN_TMSP to RUN_TMSP
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ldpl_model_run_2 (
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of a rfm model'),
model_name STRING(100) NOT NULL OPTIONS(description='Name of a frm model'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for a client'),
geo_area_cd STRING(3) NOT NULL OPTIONS(description='Iso cd identifier for a client'),
run_tmsp DATETIME OPTIONS(description='Run timestamp for a model'),
active_from_dt DATE NOT NULL OPTIONS(description='Time since the model was active'),
active_to_dt DATE NOT NULL OPTIONS(description='Time till the model was active'),
cy_week BIGNUMERIC(38,0) OPTIONS(description='Week identifier'),
cy_month BIGNUMERIC(38,0) OPTIONS(description='Month identifier'),
delete_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Indicates if the given model is out of date'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (model_sid, geo_area_sid) NOT ENFORCED
) OPTIONS(description='Latest lidlplus segment model loaded');