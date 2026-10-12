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


CREATE OR REPLACE VIEW P_LEW_MART_CS.v_lago_item
(
  client_id                                    
  , country_iso_cd   
  , item_id
  , orig_item_nr
  , orig_item_nr_int
  , case_size_lago
  , valid_from
  , valid_until
  , brand_name
  , item_actiongroup_id
  , item_sub_actiongroup_id
  , is_plu_item
  , buying_list_type_id
  , plu_nr
  , unitsize
  , buying_employee_skey
  , buying_employee_name
  , subitemgroup_id
  , int_subitemgroup_id
  , itemstatus_cd
  , packagetype_desc  
  , item_familygroup_id
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT
  i.client_id                                    
  , i.country_iso_cd   
  , i.item_id
  , i.orig_item_nr
  , i.orig_item_nr_int
  , i.case_size_lago
  , i.valid_from
  , i.valid_until
  , i.brand_name
  , i.item_actiongroup_id
  , i.item_sub_actiongroup_id
  , i.is_plu_item
  , i.buying_list_type_id
  , i.plu_nr
  , i.unitsize
  , i.buying_employee_skey
  , i.buying_employee_name
  , i.subitemgroup_id
  , i.int_subitemgroup_id
  , i.itemstatus_cd
  , i.packagetype_desc  
  , i.item_familygroup_id
  , i.cs_updated
  , i.cs_created
  , i.cs_load_id
FROM P_LEW_MART_CS.t_lago_item AS i   
;