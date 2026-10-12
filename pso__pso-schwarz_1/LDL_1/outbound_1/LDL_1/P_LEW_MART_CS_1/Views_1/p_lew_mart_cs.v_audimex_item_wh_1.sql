/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_audimex_item_wh.sql 15787 2020-08-19 12:20:28Z uross $
# $Revision: 15787 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-08-19 14:20:28 +0200 (Wed, 19 Aug 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_audimex_item_wh.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  12.08.2020    Ulrich, Ross            First Version
#----------------------------------------------------------------------------

*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_audimex_item_wh_1 (client_id, country_iso_cd, wh_id, orig_item_nr, case_size,
item_status_id, cs_updated, cs_created, cs_load_id) AS SELECT client_id,
 country_iso_cd,
 wh_id,
 orig_item_nr,
 case_size,
 item_status_id,
 cs_updated,
 cs_created,
 cs_load_id
FROM ldl_p_lew_mart_cs.t_audimex_item_wh_1;