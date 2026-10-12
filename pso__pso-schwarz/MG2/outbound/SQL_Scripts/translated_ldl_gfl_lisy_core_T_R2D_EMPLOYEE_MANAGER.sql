TRUNCATE TABLE ldl_data_production_etl.t_r2d_employee_manager;


INSERT INTO ldl_data_production_etl.t_r2d_employee_manager
WITH employee_manager AS (SELECT emp.person_sid AS emp_sid,
    GREATEST(emp.dwh_valid_from_tmsp, mgr.dwh_valid_from_tmsp) AS val_from,
    LEAST(emp.dwh_valid_to_tmsp, mgr.dwh_valid_to_tmsp) AS val_to,
    mgr.person_sid AS emp_mgr_sid,
    mgr.first_name AS mgr_first_name,
    mgr.family_name AS mgr_family_name,
    TO_HEX(CAST(SHA256(IFNULL(CAST(mgr.person_sid AS STRING), '@') || '#&#' || IFNULL(LOWER(mgr.first_name), 'Unbekannt'
           ) || '#&#' || IFNULL(LOWER(mgr.family_name), 'Unbekannt')) AS BYTES)) AS row_hash_for_diff,
    LAG(TO_HEX(CAST(SHA256(IFNULL(CAST(mgr.person_sid AS STRING), '@') || '#&#' || IFNULL(LOWER(mgr.first_name),
            'Unbekannt') || '#&#' || IFNULL(LOWER(mgr.family_name), 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(emp.person_sid AS STRING)
       ORDER BY GREATEST(emp.dwh_valid_from_tmsp, mgr.dwh_valid_from_tmsp) IS NULL, GREATEST(emp.dwh_valid_from_tmsp,
        mgr.dwh_valid_from_tmsp)) AS prev_row_hash_for_diff,
     CASE
     WHEN TO_HEX(CAST(SHA256(IFNULL(CAST(mgr.person_sid AS STRING), '@') || '#&#' || IFNULL(LOWER(mgr.first_name),
             'Unbekannt') || '#&#' || IFNULL(LOWER(mgr.family_name), 'Unbekannt')) AS BYTES)) = (LAG(TO_HEX(CAST(SHA256(IFNULL(CAST(mgr.person_sid AS STRING)
                , '@') || '#&#' || IFNULL(LOWER(mgr.first_name), 'Unbekannt') || '#&#' || IFNULL(LOWER(mgr.family_name)
             , 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(emp.person_sid AS STRING) ORDER BY GREATEST(emp.dwh_valid_from_tmsp
           , mgr.dwh_valid_from_tmsp) IS NULL, GREATEST(emp.dwh_valid_from_tmsp, mgr.dwh_valid_from_tmsp)))
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_person AS emp
    INNER JOIN ldl_data_production_core_rel.t_person AS mgr ON emp.mgr_emp_sid = mgr.person_sid AND emp.dwh_valid_from_tmsp
         <= mgr.dwh_valid_to_tmsp AND emp.dwh_valid_to_tmsp >= mgr.dwh_valid_from_tmsp AND mgr.is_emp_fg
   WHERE emp.is_emp_fg), em_with_group_ids AS (SELECT emp_sid,
    val_from,
    val_to,
    emp_mgr_sid,
    mgr_first_name,
    mgr_family_name,
    row_hash_for_diff,
    prev_row_hash_for_diff,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(emp_sid AS STRING) ORDER BY val_from IS NULL, val_from, has_change_fg
       IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM employee_manager AS em) (SELECT emp_sid,
    MIN(val_from) AS dwh_valid_from_tmsp,
    MAX(val_to) AS dwh_valid_to_tmsp,
    emp_mgr_sid,
    mgr_family_name,
    mgr_family_name AS mgr_family_name5
   FROM em_with_group_ids
   GROUP BY emp_sid,
    emp_mgr_sid,
    mgr_family_name,
    group_id);