/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs_ac.v_lago_packagetype_2
#----------------------------------------------------------------------------
# History:
#  1.0  17.06.2021    Ross, Ulrich             Initial version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_lago_packagetype_2
(
  client_id
  ,packagetype_skey
  ,language_id
  ,valid_from
  ,valid_until
  ,descr
  ,last_refresh
  ,cs_updated 
  ,cs_created
  ,cs_load_id
)
AS
SELECT
  i.client_id
  ,i.packagetype_skey
  ,i.language_id
  ,i.valid_from
  ,i.valid_until
  ,i.descr
  ,i.last_refresh
  ,i.cs_updated 
  ,i.cs_created
  ,i.cs_load_id
FROM p_lew_mart_cs.v_lago_packagetype_2 AS i   
;