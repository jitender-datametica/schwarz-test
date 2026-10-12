CREATE OR REPLACE VIEW process_mining_production_eval.v_ticket_sla_duration_solutions_2 (u_task, number, state, country_2,
u_sys_class_name, erste_relevante_gruppe, start_time, opened_at, resolved_at, sys_updated_on, business_duration,
duration_days, duration_hours, duration_hours_total) AS SELECT group_history.u_task,
 INC.number,
 INC.state,
 t_cmn_location.country_2,
 group_history.u_sys_class_name,
 t_sys_user_group.name AS erste_relevante_gruppe,
 SLA.start_time,
 INC.opened_at,
 INC.resolved_at,
 group_history.sys_updated_on,
 SLA.business_duration,
 DATETIME_DIFF(PARSE_DATETIME('%F %H:%M:%S', SLA.business_duration), PARSE_DATETIME('%F %H:%M:%S', '1970-01-01 00:00:00'
   ), DAY) AS duration_days,
 MOD(DATETIME_DIFF(PARSE_DATETIME('%F %H:%M:%S', SLA.business_duration), PARSE_DATETIME('%F %H:%M:%S',
    '1970-01-01 00:00:00'), HOUR), 24) AS duration_hours,
 DATETIME_DIFF(PARSE_DATETIME('%F %H:%M:%S', SLA.business_duration), PARSE_DATETIME('%F %H:%M:%S', '1970-01-01 00:00:00'
   ), HOUR) AS duration_hours_total
FROM (SELECT *
  FROM process_mining_production_etl.t_u_assignment_group_history_2
  WHERE u_sys_class_name = 'incident'
   AND u_assignment_group IN ('7c5f1533db883348ddce449e3b961967', '63676e16dbb501501ce29197f496191a',
     '5eba36f1db22e090ed72a6b605961947', '9bdf6e0c1b25d0501ba042eacd4bcb88', '7b5e9e9c1b9815d0d59e986c9b4bcb9b',
     'b44f55ffdb483348ddce449e3b961944', 'f29758e01ba0b8105f17a6c8, bb4bcb17', '79dfd1b7db00770070da6d340596198b',
     'e2ea303fdb2cd950799cfad3f39619be', '4c7a72b1db22e090ed72a6b605961925', '0a1ea809db7ed4dc50930a9bd3961948',
     '06f8a54adb4114d408cfba03f39619cd', '84aa7eb1db22e090ed72a6b60596191b', '845f5133db883348ddce449e3b961987',
     '7a62fec41b219050af067553dd4bcbad', 'fffa06f6dbe6185c50930a9bd3961940', '62a5a2a9974165905959fc000153afc1',
     '352a3a31db22e090ed72a6b605961920', 'd8199ae61b09805c8e8655be6e4bcbe4', 'cfdbeead1bf14c58ced57448cd4bcb3a',
     '89934d5d6f0b7600ec1748f42e3ee41c', '42970f07978039d4dc2330200153af3a', '269f6c63db8c3b08ddce449e3b96194f',
     '6ff28cf1db34af8cb4062e65ca961942', 'f2df15b7db00770070da6d34059619f1', 'd0df11b7db00770070da6d34059619e2',
     'e68ab6b1db22e090ed72a6b60596196e')) AS group_history
 LEFT JOIN process_mining_production_etl.t_sys_user_group_2 ON group_history.u_assignment_group = t_sys_user_group.sys_id
 LEFT JOIN process_mining_production_etl.t_incident_2 AS INC ON group_history.u_task = INC.sys_id
 LEFT JOIN process_mining_production_etl.t_task_sla_2 AS SLA ON group_history.u_task = SLA.task
 LEFT JOIN process_mining_production_etl.t_contract_sla_2 AS CONTRACT ON SLA.sla = CONTRACT.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_location_2 ON INC.location_2 = t_cmn_location.sys_id
WHERE SLA.start_time > CAST('2023-05-01 00:00:00' AS DATETIME)
 AND CONTRACT.name LIKE '%resolution'
QUALIFY (ROW_NUMBER() OVER (PARTITION BY group_history.u_task ORDER BY group_history.sys_updated_on IS NULL DESC,
      group_history.sys_updated_on DESC)) = 1;