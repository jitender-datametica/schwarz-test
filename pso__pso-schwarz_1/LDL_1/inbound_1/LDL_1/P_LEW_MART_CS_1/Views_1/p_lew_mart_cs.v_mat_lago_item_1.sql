/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_lago_item.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_lago_item.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  30.09.2020    Ulrich, Ross            First Version
#  1.1  17.09.2021    Ulrich, Ross            Add itemstatus_cd in qualify order by to get distinct itemstatus_cd. Because every WH have an itemstatus_cd for an article
#  1.2  13.10.2021    Ulrich, Ross            Add case function for orig_item_nr_int; when -1 as orig_item_nr_int then change to NULL (LAGO needs a NULL value)
#                                             Add case function for packagetype_desc; when '#NA#' as packagetype_desc then change to NULL (LAGO needs a NULL value)
#                                             Add case function for buying_employee_name; when '#NA#' as buying_employee_name then change to NULL (LAGO needs a NULL value)
#  1.3  05.01.2022    Lin, Ao                 Add default value of 999 for item_familygroup_id through COALESCE
#  1.4  07.01.2022    Lin, Ao                 Reverts changes from v1.3, changes column item_familygroup_id to use value from item_familygroup_id_lago
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_CS.v_mat_lago_item_1
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
  , plu_nr
  , buying_list_type_id  
  , unitsize
  , buying_employee_skey
  , buying_employee_name
  , subitemgroup_id
  , int_subitemgroup_id
  , itemstatus_cd
  , packagetype_desc  
  , item_familygroup_id
  , dwh_updated
  , dwh_created
  , dwh_load_id
)
AS
SELECT
     i.client_id                                  AS client_id
   , i.src_country_lidl_cd                        AS country_iso_cd   
   , i.item_sid                                   AS item_id
   , i.orig_item_nr
   , CASE WHEN i.orig_item_nr_int = -1
          THEN NULL
          ELSE  i.orig_item_nr_int
     END                                          AS orig_item_nr_int
   , i.case_size_lago
   , i.valid_from
   , i.valid_until
   , TRIM(i.brand_name)                           AS brand_name
   , COALESCE(i.item_actiongroup_id, -1)          AS item_actiongroup_id
   , COALESCE(i.item_sub_actiongroup_id, -1)      AS item_sub_actiongroup_id
   , CASE WHEN i.case_plu_fg > 0
          THEN 1
          ELSE 0
     END                                          AS is_plu_item
   , i.plu_nr
   , i.buying_list_type_id   
   , i.unitsize
   , i.buying_employee_skey                       AS buying_employee_skey
   , CASE WHEN TRIM(i.buying_employee_name) = '#'||'NA'||'#'
         THEN NULL
         ELSE TRIM(i.buying_employee_name)      
     END                                          AS buying_employee_name
   , COALESCE(i.subitemgroup_id, -1000)           AS subitemgroup_id
   , COALESCE(i.int_subitemgroup_id, -2000)       AS int_subitemgroup_id
   , i.itemstatus_cd
   , CASE WHEN  i.packagetype_desc = '#'||'NA'||'#'
          THEN NULL
          ELSE  i.packagetype_desc
     END                                          AS  packagetype_desc
   , i.item_familygroup_id_lago                   AS  item_familygroup_id
   , i.dwh_updated
   , i.dwh_created
   , i.dwh_load_id
FROM P_LEW_MART_CS.v_gen_item_asis_1 AS i
WHERE CURRENT_DATE BETWEEN i.valid_from AND i.valid_until
   AND i.orig_item_nr > 0    
   QUALIFY ROW_NUMBER() OVER (PARTITION BY i.client_id, i.item_sid  ORDER BY  i.valid_from ASC, i.itemstatus_cd ASC ) = 1 -- Eindeutige Identifizierung
;


