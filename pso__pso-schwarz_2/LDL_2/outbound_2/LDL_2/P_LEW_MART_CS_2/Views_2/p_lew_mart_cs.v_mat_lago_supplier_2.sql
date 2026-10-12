/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_lago_supplier.sql 16463 2020-12-15 16:25:21Z cwachauf $
# $Revision: 16463 $
# $LastChangedBy: cwachauf $
# $LastChangedDate: 2020-12-15 17:25:21 +0100 (Di, 15 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_lago_supplier.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  23.10.2020    Ulrich, Ross            First Version
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_lago_supplier_2 (client_id, country_iso_cd, orig_supplier_nr, supplier_id,
dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT client_id,
 country_iso_cd,
 orig_supplier_nr,
 supplier_id,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
FROM ldl_p_lew_mart_cs.v_cs_item_brand_2 AS SUP
WHERE supplier_id > 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(orig_supplier_nr AS STRING), CAST(supplier_id AS STRING)
      ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1 -- Eindeutige Identifizierung
;