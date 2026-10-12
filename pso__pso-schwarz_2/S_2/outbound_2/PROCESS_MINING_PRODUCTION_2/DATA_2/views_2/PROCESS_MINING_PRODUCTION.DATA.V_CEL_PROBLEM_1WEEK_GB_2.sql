CREATE OR REPLACE VIEW process_mining_production_data.v_cel_problem_1week_gb_2 (sys_id, number, description,
short_description, sys_created_on, priority, u_close_code, related_incidents) AS SELECT sys_id,
 number,
 description,
 short_description,
 sys_created_on,
 priority,
 u_close_code,
 related_incidents
FROM process_mining_production_etl.t_problem_2
WHERE (u_division_business_region LIKE '%16444461db06f200a880fdabbf9619bb%' OR u_division_business_region LIKE
    '%f766a8c0db0a3200a880fdabbf9619a5%')
 AND sys_created_on >= CAST('2024-01-01 00:00:00' AS DATETIME)
 AND number IN ('PRB0101303', 'PRB0101355', 'PRB0101355', 'PRB0101355', 'PRB0101355', 'PRB0101355', 'PRB0101355',
   'PRB0101221', 'PRB0101355', 'PRB0096593', 'PRB0101208', 'PRB0099684', 'PRB0101791', 'PRB0101303', 'PRB0096593',
   'PRB0100393');