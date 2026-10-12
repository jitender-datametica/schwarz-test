/* #-----------------------------------------------------------------------------
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
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_parameter_vt (param_id OPTIONS(description='Parameter ID'), client_id
OPTIONS(description='Client ID to which the parameter should be applied.'), val_int
OPTIONS(description='Integer parameter value'), val_date OPTIONS(description='Date parameter value'), val_varchar
OPTIONS(description='STRING parameter value'), comments OPTIONS(description='Description of paramater and value')) AS
SELECT t0.param_id,
 t0.client_id,
 t0.val_int,
 t0.val_date,
 t0.val_varchar,
 t0.comments
FROM (SELECT DISTINCT D.param_id,
   C.client_id,
   FIRST_VALUE(D.val_int) OVER (PARTITION BY D.param_id, C.client_id ORDER BY CASE
       WHEN D.client_id = 7
       THEN 2
       ELSE 1
       END IS NULL, CASE
       WHEN D.client_id = 7
       THEN 2
       ELSE 1
       END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS val_int,
   FIRST_VALUE(D.val_date) OVER (PARTITION BY D.param_id, C.client_id ORDER BY CASE
       WHEN D.client_id = 7
       THEN 2
       ELSE 1
       END IS NULL, CASE
       WHEN D.client_id = 7
       THEN 2
       ELSE 1
       END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS val_date,
   FIRST_VALUE(D.val_varchar) OVER (PARTITION BY D.param_id, C.client_id ORDER BY CASE
       WHEN D.client_id = 7
       THEN 2
       ELSE 1
       END IS NULL, CASE
       WHEN D.client_id = 7
       THEN 2
       ELSE 1
       END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS val_varchar,
   FIRST_VALUE(D.comments) OVER (PARTITION BY D.param_id, C.client_id ORDER BY CASE
       WHEN D.client_id = 7
       THEN 2
       ELSE 1
       END IS NULL, CASE
       WHEN D.client_id = 7
       THEN 2
       ELSE 1
       END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS comments
  FROM ldl_p_lew_mart_lead.t_ref_parameter_vt AS D
   INNER JOIN ldl_p_lew_core_ac.v_client AS C ON D.client_id = CASE
        WHEN D.client_id = 7
        THEN D.client_id
        ELSE C.client_id
        END AND C.client_id <> 7 AND C.lob_cd = 'LDL' AND C.client_online_fg = 0) AS t0;