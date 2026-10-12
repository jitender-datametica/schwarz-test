/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_lago_itemfamily.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_lago_itemfamily.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  29.09.2020    Ross, Ulrich               Initial version
#----------------------------------------------------------------------------

*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_lago_itemfamily_1 (client_id, country_iso_cd, dat_rec_start, dat_rec_end,
item_familygroup_id, itemfamily_cd, desc_short, desc_long, language_id, cs_updated, cs_created, cs_load_id) AS SELECT
 client_id,
 country_iso_cd,
 dat_rec_start,
 dat_rec_end,
 item_familygroup_id,
 itemfamily_cd,
 desc_short,
 desc_long,
 language_id,
 cs_updated,
 cs_created,
 cs_load_id
FROM ldl_p_lew_mart_cs.t_lago_itemfamily_1 AS A;