/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_lago_item_descr.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_lago_item_descr.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  23.10.2020    Wachauf, Christian            First Version
#  1.1  07.01.2022    Ao, Lin                       Change column item_familygroup_id to use value from item_familygroup_id_lago
#  1.2  26.04.2023    Ross, Ulrich                  Remove column item_familygroup_id_lago add QUALIFY ROW_NUMBER to remove duplicate key error
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_lago_item_descr_2 (client_id, item_id, orig_item_nr, item_descr,
language_id, valid_from, valid_until, dwh_updated, dwh_created, dwh_load_id) AS -- gen_item_as_is

-- nur Landessprache und International
 SELECT GIAI.client_id,
 GIAI.item_sid AS item_id,
 GIAI.orig_item_nr,
 ITDESC.item_descr,
 ITDESC.language_id,
 GIAI.valid_from,
 GIAI.valid_until,
 ITDESC.dwh_updated,
 ITDESC.dwh_created,
 ITDESC.dwh_load_id
FROM ldl_p_lew_mart_cs.v_gen_item_asis_2 AS GIAI
 INNER JOIN ldl_p_lew_mart_cs.v_cs_item_descr_2 AS ITDESC ON GIAI.client_id = ITDESC.client_id AND GIAI.item_sid = ITDESC
   .item_id
WHERE CURRENT_DATE BETWEEN GIAI.valid_from AND GIAI.valid_until
 AND (GIAI.client_id = ITDESC.language_id OR ITDESC.language_id = 7)
GROUP BY GIAI.client_id,
 item_id,
 GIAI.orig_item_nr,
 ITDESC.item_descr,
 ITDESC.language_id,
 GIAI.valid_from,
 GIAI.valid_until,
 ITDESC.dwh_updated,
 ITDESC.dwh_created,
 ITDESC.dwh_load_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(GIAI.client_id AS STRING), CAST(item_id AS STRING), GIAI.orig_item_nr,
      ITDESC.item_descr, CAST(ITDESC.language_id AS STRING), GIAI.valid_from, GIAI.valid_until ORDER BY ITDESC.dwh_load_id
      IS NULL DESC, ITDESC.dwh_load_id DESC)) = 1;