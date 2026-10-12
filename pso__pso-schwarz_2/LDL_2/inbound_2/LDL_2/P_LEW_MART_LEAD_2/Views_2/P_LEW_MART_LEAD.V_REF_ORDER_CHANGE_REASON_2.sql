/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_REF_ORDER_CHANGE_REASON_2
#----------------------------------------------------------------------------
# History:
#  1.0  14.08.2023    Bachmann, Torsten        Initial version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_ORDER_CHANGE_REASON_2 (
  reason_cd
, reason_desc
) AS
SELECT
  reason_cd
, reason_desc
FROM P_LEW_MART_LEAD.T_REF_ORDER_CHANGE_REASON_2
;