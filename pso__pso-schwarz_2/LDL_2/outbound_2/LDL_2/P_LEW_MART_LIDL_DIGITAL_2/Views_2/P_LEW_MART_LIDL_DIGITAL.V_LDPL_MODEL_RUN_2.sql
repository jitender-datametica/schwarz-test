/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: V_LDPL_MODEL_RUN_2
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
#  1.2 2022-07-26 Pawel Wieczorek  Removing column BUSYEAR_QTR, renaming from LAST_RUN_TMSP to RUN_TMSP
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ldpl_model_run_2 (model_sid OPTIONS(description='ID of a rfm model'),
model_name OPTIONS(description='Name of a frm model'), geo_area_sid OPTIONS(description='Identifier for a client'),
geo_area_cd OPTIONS(description='Iso cd identifier for a client'), run_tmsp
OPTIONS(description='Run timestamp for a model'), active_from_dt OPTIONS(description='Time since the model was active'),
active_to_dt OPTIONS(description='Time till the model was active'), cy_week OPTIONS(description='Week identifier'),
cy_month OPTIONS(description='Month identifier'), delete_fg
OPTIONS(description='Indicates if the given model is out of date'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LATEST LIDLPLUS SEGMENT MODEL LOADED FROM THE CORE LAYER`) AS SELECT model_sid,
 model_name,
 geo_area_sid,
 geo_area_cd,
 run_tmsp,
 active_from_dt,
 active_to_dt,
 cy_week,
 cy_month,
 delete_fg,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ldpl_model_run_2;