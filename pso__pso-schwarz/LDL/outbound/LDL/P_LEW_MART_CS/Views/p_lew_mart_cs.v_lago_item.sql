/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_lago_item.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_lago_item.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  30.09.2020    Ulrich, Ross            First Version
#----------------------------------------------------------------------------

*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_lago_item (client_id, country_iso_cd, item_id, orig_item_nr, orig_item_nr_int
, case_size_lago, valid_from, valid_until, brand_name, item_actiongroup_id, item_sub_actiongroup_id, is_plu_item,
buying_list_type_id, plu_nr, unitsize, buying_employee_skey, buying_employee_name, subitemgroup_id, int_subitemgroup_id
, itemstatus_cd, packagetype_desc, item_familygroup_id, cs_updated, cs_created, cs_load_id) AS SELECT client_id,
 country_iso_cd,
 item_id,
 orig_item_nr,
 orig_item_nr_int,
 case_size_lago,
 valid_from,
 valid_until,
 brand_name,
 item_actiongroup_id,
 item_sub_actiongroup_id,
 is_plu_item,
 buying_list_type_id,
 plu_nr,
 unitsize,
 buying_employee_skey,
 buying_employee_name,
 subitemgroup_id,
 int_subitemgroup_id,
 itemstatus_cd,
 packagetype_desc,
 item_familygroup_id,
 cs_updated,
 cs_created,
 cs_load_id
FROM ldl_p_lew_mart_cs.t_lago_item AS I;