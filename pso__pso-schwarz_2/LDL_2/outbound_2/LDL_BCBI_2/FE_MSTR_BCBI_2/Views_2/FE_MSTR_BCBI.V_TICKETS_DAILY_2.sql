CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_tickets_daily_2 AS SELECT CASE
  WHEN task_type = 'Spezifikation'
  THEN REPLACE(CONCAT(task_type, '_', opened_at), ' ', '_')
  ELSE REPLACE(CONCAT(task_type, '_', first_assignment_group, '_', opened_at), ' ', '_')
  END AS id,
 location_2 AS country_ticket_id,
 subject,
 state AS status_,
 task_type AS type,
 solution,
 affected_ci AS ci,
 priority,
 assignment_group AS assigned_to_group,
 assignment_group_history,
 first_assignment_group AS opened_by_group,
 opened_at AS created_on,
 updated_at AS changed_on,
 upload_date
FROM ldl_bcbi_fe_mstr_bcbi.t_tickets_daily_2;