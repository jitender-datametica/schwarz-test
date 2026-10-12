/*
#----------------------------------------------------------------------------
# COUNTRY TRANSLATION LIST
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2022-03-03 Rafal Rudnik          SD-2524 Initial version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_country_trans_list (client_id OPTIONS(description='Client_ID'),
iso_code OPTIONS(description='ISO Language Code'), lang_postfix OPTIONS(description='column postfix for translation'))
OPTIONS(DESCRIPTION = `LIST OF LANGUAGES AVAIABLE FOR TRANSLATION`) AS SELECT client_id,
 country_cd AS iso_code,
 CONCAT('_', LOWER(country_cd)) AS lang_postfix
FROM ldl_p_lew_process.t_lidlplus_config_client;