/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for d_lew_process.t_sharepoint_sdl_integration_1
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_process_t_sharepoint_sdl_integration.sql 16424 2020-12-03 17:04:50Z dcamerzan $
# $Revision: 16424 $
# $LastChangedBy: dcamerzan $
# $LastChangedDate: 2020-12-03 18:04:50 +0100 (Thu, 03 Dec 2020) $
# $URL: svn://l-as616.asp.lidl.net/DDL/lew/lew_process/lew_process_t_sharepoint_sdl_integration.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  28.10.2020    Dumitru Camerzan         Initial version
#  1.1  03.12.2020    Camerzan,Dumitru         Improvements after SDL process bugfixing.
#----------------------------------------------------------------------------
*/
/*
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_sharepoint_sdl_integration_1 (
process_name STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='The name of the SDL Reporting Process Plan (or its PSET).'),
etl_version NUMERIC(18,5)
OPTIONS(description='The Sharepoint Document Version of the SDL Exception List this SDL plan execution relates to.'),
load_id INTEGER OPTIONS(description='The Load ID of the SDL plan execution.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp when this process entry is created.')
)
OPTIONS(description='$Revision: 16424 $ Patch 2636: This table contains the executions of SDL Reporting Process related AI-Plans (patch A2924) from lew_shrepoint_stg, lew_sharepoint_core and lew_sharepoint_exp AI-projects.');