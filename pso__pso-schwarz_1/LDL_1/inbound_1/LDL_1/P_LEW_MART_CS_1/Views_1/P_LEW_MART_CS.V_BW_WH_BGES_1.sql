/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_WH_BGES_1
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501418
#                                             
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_WH_BGES_1
(
    client_id
  , client_desc
  , wh_id
  , bges_desc1
  , bges_desc2
 )
AS
SELECT 
      wh.client_id                            AS client_id
    , cl.country_iso_cd                       AS country_iso_cd
    , wh.src_wh_id                            AS wh_id
    , wh.loc_name                             AS bges_desc1
    , wh.loc_name2                            AS bges_desc2
    
FROM p_lew_bil.v_warehouse_1                         AS wh

INNER JOIN p_lew_mart_msi_ac.v_ref_client_lead_1     AS cl
  ON wh.client_id = cl.client_id

WHERE CURRENT_DATE - 1 BETWEEN wh.dwh_valid_from  AND wh.dwh_valid_to
  AND wh.bges_active_fg = 1
  AND wh.active_fg = 1
   ;