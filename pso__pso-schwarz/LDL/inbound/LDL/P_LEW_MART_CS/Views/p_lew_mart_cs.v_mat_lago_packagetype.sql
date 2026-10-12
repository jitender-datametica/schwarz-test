/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_mat_lago_packagetype
#----------------------------------------------------------------------------
# History:
#  1.0  16.06.2021    Ross, Ulrich             Initial version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_lago_packagetype
(
client_id
,packagetype_skey
,language_id
,valid_from
,valid_until
,descr
,last_refresh
,src_id
,load_id
)
AS
SELECT 
client_id
, packagetype_skey
, language_id
, valid_from
, valid_until
, COALESCE(descr, 'tbd')
, last_refresh
, src_id
, load_id
FROM p_lew_mart_cs.v_cs_packagetype
;