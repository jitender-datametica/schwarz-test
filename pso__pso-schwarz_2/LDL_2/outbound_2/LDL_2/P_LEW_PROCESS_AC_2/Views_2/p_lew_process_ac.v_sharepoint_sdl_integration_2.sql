/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for d_lew_process_ac.v_sharepoint_sdl_integration_2
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_process_ac_v_sharepoint_sdl_integration.sql 16423 2020-12-03 17:04:35Z dcamerzan $
# $Revision: 16423 $
# $LastChangedBy: dcamerzan $
# $LastChangedDate: 2020-12-03 18:04:35 +0100 (Thu, 03 Dec 2020) $
# $URL: svn://l-as616.asp.lidl.net/DDL/lew/lew_process_ac/lew_process_ac_v_sharepoint_sdl_integration.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  28.10.2020    Dumitru Camerzan         Initial version
#  1.1  03.12.2020    Camerzan,Dumitru         Improvements after SDL process bugfixing.
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_sharepoint_sdl_integration_2 (process_name, etl_version, load_id,
dwh_created) AS SELECT process_name,
 etl_version,
 load_id,
 dwh_created
FROM ldl_p_lew_process.t_sharepoint_sdl_integration_2;