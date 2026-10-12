CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_PARAMETER_VT_1
(
  param_id          COMMENT 'Parameter ID'
, client_id         COMMENT 'Client ID to which the parameter should be applied.'
, val_int           COMMENT 'Integer parameter value'
, val_date          COMMENT 'Date parameter value'
, val_varchar       COMMENT 'Varchar parameter value'
, comments          COMMENT 'Description of paramater and value'
)
AS
/*
#-----------------------------------------------------------------------------
# Description:
# This view provides lists all the parameters from the Solution VT parameter table. 
#
# Parameters with the International client_id = 7 (generic) will generate records for clients with
# an internal priority of 2. Parameters with an explicit client_id are given a priority
# of 1. This ensures that explicit values have priority over generic values. 
#-----------------------------------------------------------------------------
# History:
#  1.0     15.08.2022      Michael Morris             Initial Version.
#
#-----------------------------------------------------------------------------
*/
SELECT param_id, client_id, val_int, val_date, val_varchar, comments
  FROM (
        SELECT DISTINCT   param_id
                        , client_id
                        , FIRST_VALUE(val_int)      OVER (PARTITION BY param_id, client_id ORDER BY prio) AS val_int
                        , FIRST_VALUE(val_date)     OVER (PARTITION BY param_id, client_id ORDER BY prio) AS val_date
                        , FIRST_VALUE(val_varchar)  OVER (PARTITION BY param_id, client_id ORDER BY prio) AS val_varchar
                        , FIRST_VALUE(comments)     OVER (PARTITION BY param_id, client_id ORDER BY prio) AS comments
         FROM (
               SELECT   d.param_id
                      , c.client_id
                      , CASE WHEN d.client_id = 7 THEN 2 ELSE 1 END AS prio
                      , d.val_int
                      , d.val_date
                      , d.val_varchar
                      , comments
                 FROM P_LEW_MART_LEAD.T_REF_PARAMETER_VT_1 AS d
                INNER JOIN P_LEW_CORE_AC.v_client_1        AS c
                   ON d.client_id       = CASE WHEN d.client_id = 7 THEN d.client_id ELSE c.client_id END
                  AND c.client_id      <> 7
                  AND c.lob_cd          = 'LDL'
                  AND client_online_fg  = 0
         
              )
)
;