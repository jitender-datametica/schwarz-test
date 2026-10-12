/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for d_lew_process.t_sharepoint_sdl_integration_2
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
CREATE  TABLE P_LEW_PROCESS.t_sharepoint_sdl_integration_2 (
      process_name VARCHAR(100) COLLATE 'en-ci' NOT NULL comment 'The name of the SDL Reporting Process Plan (or its PSET).',
      etl_version DECIMAL(18,5) comment 'The Sharepoint Document Version of the SDL Exception List this SDL plan execution relates to.',
      load_id INTEGER comment 'The Load ID of the SDL plan execution.',
      dwh_created TIMESTAMP_NTZ NOT NULL comment 'Timestamp when this process entry is created.')
	  comment = '$Revision: 16424 $ Patch 2636: This table contains the executions of SDL Reporting Process related AI-Plans (patch A2924) from lew_shrepoint_stg, lew_sharepoint_core and lew_sharepoint_exp AI-projects.'
;
