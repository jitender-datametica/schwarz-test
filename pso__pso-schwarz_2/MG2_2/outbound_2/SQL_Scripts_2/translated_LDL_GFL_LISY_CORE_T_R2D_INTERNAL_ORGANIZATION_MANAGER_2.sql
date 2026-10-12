INSERT INTO ldl_data_production_etl.t_r2d_internal_organization_manager_2 (
    int_org_sid,
    job_role_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    int_org_mgr_sid,
    int_org_mgr_nr,
    int_org_mgr_first_name,
    int_org_mgr_last_name,
    int_org_mgr_full_name
)
WITH
int_org_mgr_dedup AS (
    SELECT
        emp_sid,
        job_role_sid,
        dwh_valid_from_tmsp,
        dwh_valid_to_tmsp,
        dwh_valid_fg,
        dwh_created_tmsp,
        dwh_updated_tmsp,
        dwh_load_id,
        dwh_node_cd
    FROM ldl_data_production_core_rel.t_employee_job_role_2
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY job_role_sid
        ORDER BY dwh_valid_from_tmsp DESC
    ) = 1
),
int_org_manager AS (
    SELECT
        jr.int_org_sid,
        jr.job_role_type_cd,
        MIN(
            GREATEST(
                io.dwh_valid_from_tmsp,
                jr.dwh_valid_from_tmsp,
                per.dwh_valid_from_tmsp
            )
        ) AS val_from,
        per.person_sid                AS int_org_mgr_sid,
        per.emp_nr                    AS int_org_mgr_nr,
        per.first_name                AS int_org_mgr_first_name,
        per.family_name               AS int_org_mgr_last_name,
        CASE
            WHEN per.family_name = 'VW' THEN 'VW'
            ELSE LTRIM(
                   COALESCE(
                     CONCAT(
                       INITCAP(REGEXP_REPLACE(per.first_name, '[0-9]', '')),
                       ' ',
                       INITCAP(REGEXP_REPLACE(per.family_name, '[0-9]', ''))
                     ),
                     'Unbekannt'
                   ),
                   ' '
                 )
        END AS int_org_mgr_full_name
    FROM ldl_data_production_core_rel.t_internal_organization_2 io
    JOIN ldl_data_production_core_rel.t_job_role_2 jr
      ON jr.int_org_sid = io.int_org_sid
     AND jr.dwh_valid_from_tmsp <= io.dwh_valid_to_tmsp
     AND jr.dwh_valid_to_tmsp   >= io.dwh_valid_from_tmsp
    JOIN int_org_mgr_dedup ejr
      ON ejr.job_role_sid = jr.job_role_sid
    JOIN ldl_data_production_core_rel.t_person_2 per
      ON per.person_sid = ejr.emp_sid
     AND per.dwh_valid_from_tmsp <= LEAST(jr.dwh_valid_to_tmsp, io.dwh_valid_to_tmsp)
     AND per.dwh_valid_to_tmsp   >= GREATEST(jr.dwh_valid_from_tmsp, io.dwh_valid_from_tmsp)
    WHERE 1 = 1
      AND jr.job_role_type_cd IN (
          'SALES_MANAGER',
          'ACCOUNT_MANAGER',
          'COMPANY_MANAGER',
          'REGION_MANAGER',
          'COUNTRY_ORG_MANAGER',
          'COUNTRY_GRP_MANAGER'
      )
      AND (
          (io.int_org_type_cd IN ('STORE', 'COMPANY') AND io.dwh_node_cd <> 'P_LEW_CORE')
        OR io.int_org_type_cd NOT IN ('STORE','COMPANY')
      )
    GROUP BY
        jr.int_org_sid,
        jr.job_role_type_cd,
        int_org_mgr_sid,
        int_org_mgr_nr,
        int_org_mgr_first_name,
        int_org_mgr_last_name,
        int_org_mgr_full_name
)
SELECT
    int_org_sid,
    job_role_type_cd,
    val_from AS dwh_valid_from_tmsp,
    COALESCE(
      DATETIME_SUB(
        LEAD(int_org_manager.val_from, 1) 
          OVER (PARTITION BY int_org_manager.int_org_sid,
                           int_org_manager.job_role_type_cd
                ORDER BY IF(int_org_manager.val_from IS NULL, 0, 1) DESC,
                         int_org_manager.val_from),
        INTERVAL 1 MILLISECOND
      ),
      TIMESTAMP('9999-12-31 23:59:59.999999999')
    ) AS dwh_valid_to_tmsp,
    int_org_mgr_sid,
    int_org_mgr_nr,
    int_org_mgr_first_name,
    int_org_mgr_last_name,
    int_org_mgr_full_name
FROM int_org_manager
GROUP BY
    int_org_sid,
    job_role_type_cd,
    val_from,
    int_org_mgr_sid,
    int_org_mgr_nr,
    int_org_mgr_first_name,
    int_org_mgr_last_name,
    int_org_mgr_full_name
;