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


CREATE OR REPLACE VIEW P_LEW_MART_CS.v_mat_lago_supplier_2
(
  client_id,
  country_iso_cd,
  orig_supplier_nr,
  supplier_id,
  dwh_updated,
  dwh_created,
  dwh_load_id,
  load_id,
  src_id 
)
AS
SELECT
  sup.client_id,
  sup.country_iso_cd,
  sup.orig_supplier_nr,
  sup.supplier_id,
  sup.dwh_updated,
  sup.dwh_created,
  sup.dwh_load_id,
  sup.load_id,
  sup.src_id
FROM P_LEW_MART_CS.v_cs_item_brand_2 AS sup  
WHERE sup.supplier_id > 0
QUALIFY ROW_NUMBER() OVER (PARTITION BY sup.client_id, sup.orig_supplier_nr, sup.supplier_id ORDER BY sup.dwh_updated desc ) = 1 -- Eindeutige Identifizierung
;
