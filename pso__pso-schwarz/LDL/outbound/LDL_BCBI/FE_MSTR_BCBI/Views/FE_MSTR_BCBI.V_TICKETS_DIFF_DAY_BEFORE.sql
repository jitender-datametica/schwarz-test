-- eingehende Tickets
 -- ausgehende Tickets
 CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_tickets_diff_day_before AS
SELECT *
FROM (SELECT ticket_id,
    team,
    assigned_to_group_id,
    assigned_to_group,
    topic,
    status_id,
    status_desc,
    created_on_date,
    changed_on,
    subject,
    type_id,
    type_desc,
    'Bearbeitete Tickets' AS progress
   FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_it4you
   WHERE upload_date = CASE
      WHEN EXTRACT(DAYOFWEEK FROM CURRENT_DATE) - 1 = 1
      THEN DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY)
      ELSE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
      END
    AND export_fg = 'Morgen'
   EXCEPT DISTINCT
   SELECT t1.ticket_id,
    t1.team,
    t1.assigned_to_group_id,
    t1.assigned_to_group,
    t1.topic,
    t1.status_id,
    t1.status_desc,
    t1.created_on_date,
    t1.changed_on,
    t1.subject,
    t1.type_id,
    t1.type_desc,
    'Bearbeitete Tickets' AS progress
   FROM (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_it4you
     WHERE upload_date = CASE
        WHEN EXTRACT(DAYOFWEEK FROM CURRENT_DATE) - 1 = 1
        THEN DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY)
        ELSE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
        END
      AND export_fg = 'Morgen') AS t1
    INNER JOIN (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_it4you
     WHERE upload_date = CURRENT_DATE
      AND export_fg = 'Morgen') AS t2 ON t1.ticket_id = t2.ticket_id)
UNION DISTINCT
SELECT *
FROM (SELECT ticket_id,
    team,
    assigned_to_group_id,
    assigned_to_group,
    topic,
    status_id,
    status_desc,
    created_on_date,
    changed_on,
    subject,
    type_id,
    type_desc,
    'Eingegangene Tickets' AS progress
   FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_it4you
   WHERE upload_date = CURRENT_DATE -- AND status_ = '14 Offen'

    AND export_fg = 'Morgen'
   EXCEPT DISTINCT
   SELECT t1.ticket_id,
    t1.team,
    t1.assigned_to_group_id,
    t1.assigned_to_group,
    t1.topic,
    t1.status_id,
    t1.status_desc,
    t1.created_on_date,
    t1.changed_on,
    t1.subject,
    t1.type_id,
    t1.type_desc,
    'Eingegangene Tickets' AS progress
   FROM (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_it4you
     WHERE upload_date = CURRENT_DATE
      AND export_fg = 'Morgen') AS t1
    INNER JOIN (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_it4you
     WHERE upload_date = CASE
        WHEN EXTRACT(DAYOFWEEK FROM CURRENT_DATE) - 1 = 1
        THEN DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY)
        ELSE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
        END
      AND export_fg = 'Morgen') AS t2 ON t1.ticket_id = t2.ticket_id);