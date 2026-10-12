/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_lago_supp_item_wh.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_lago_supp_item_wh.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  26.10.2020    Ulrich, Ross            First Version
#----------------------------------------------------------------------------
*/


/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_lago_supp_item_wh_2 (client_id, country_iso_cd, wh_id, supplier_id, item_id
, valid_from, valid_until, dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT client_id,
 country_iso_cd,
 wh_id,
 supplier_id,
 item_id,
 valid_from,
 valid_until,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
FROM ldl_p_lew_mart_cs.v_cs_item_brand_2 AS SUP
WHERE supplier_id > 0
 AND CURRENT_DATE BETWEEN valid_from AND valid_until
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), CAST(supplier_id AS STRING), CAST(item_id AS STRING)
      ORDER BY valid_from IS NULL, valid_from)) = 1 -- Eindeutige Identifizierung
;