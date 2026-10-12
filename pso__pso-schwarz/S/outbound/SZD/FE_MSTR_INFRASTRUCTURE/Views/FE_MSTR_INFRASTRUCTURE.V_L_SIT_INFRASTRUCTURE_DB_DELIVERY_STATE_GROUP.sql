CREATE OR REPLACE VIEW szd_fe_mstr_infrastructure.v_l_sit_infrastructure_db_delivery_state_group AS SELECT
 db_delivery_state_group_id,
 db_delivery_state_group_descr
FROM (SELECT 1 AS db_delivery_state_group_id,
    'Domain mit freien DBs' AS db_delivery_state_group_descr
   UNION ALL
   SELECT 2 AS db_delivery_state_group_id,
    'Domain ohne freie DBs' AS db_delivery_state_group_descr);