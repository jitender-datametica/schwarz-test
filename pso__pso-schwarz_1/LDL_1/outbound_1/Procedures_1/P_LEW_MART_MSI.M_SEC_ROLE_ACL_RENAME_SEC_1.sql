CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.m_sec_role_acl_rename_sec`(
    SECURITY_ROLE_DESC_OLD STRING, 
    SECURITY_ROLE_DESC_NEW STRING, 
    ENTRY_USER STRING
)
BEGIN
    DECLARE sql_stmt STRING;

    BEGIN TRANSACTION;

    -- create new load_id if there is no load_id existing for the current_date
    SET sql_stmt = '''
        INSERT INTO `p_lew_mart_msi.t_sys_load_status_acl_1` (
            jobname, instance_id, load_id, flag_change
        ) 
        SELECT
            'sec_role' AS jobname,
            CURRENT_DATETIME() AS instance_id,
            l.load_id AS load_id,
            1
        FROM (
            SELECT
                MAX(instance_id) AS max_date,
                CASE
                    WHEN CURRENT_DATE() != CAST(MAX(instance_id) AS DATE) THEN (
                        SELECT MAX(load_id) + 1 
                        FROM `p_lew_mart_msi.t_sys_load_status_acl_1` 
                    )
                    ELSE MAX(load_id) 
                END AS load_id
            FROM `p_lew_mart_msi.t_sys_load_status_acl_1`
            WHERE CURRENT_DATE() != CAST((SELECT MAX(instance_id) FROM `p_lew_mart_msi.t_sys_load_status_acl_1`) AS DATE)
            GROUP BY jobname
        ) AS l
    ''';
    EXECUTE IMMEDIATE (sql_stmt);

    SET sql_stmt = '''
        DELETE FROM `p_lew_mart_msi.t_sec_role_obj_acl_tmpl_1`
        WHERE attribute_frst = @SECURITY_ROLE_DESC_OLD
          AND change_type = 'RENAME_SEC'
    ''';
    EXECUTE IMMEDIATE (sql_stmt) 
        USING SECURITY_ROLE_DESC_OLD AS SECURITY_ROLE_DESC_OLD;

    -- Insert the change_request into the tmpl
	-- entry_user and approval_user are not used actually. So its not important that there are the 
    SET sql_stmt = '''
        INSERT INTO `p_lew_mart_msi.t_sec_role_obj_acl_tmpl_1` (
            change_type, attribute_frst, attribute_scnd, change_type_value, 
            change_dat, load_id, approval_user, entry_user
        ) 
        SELECT
            mp.change_type, mp.attribute_frst, mp.attribute_scnd, mp.change_type_value,
            mp.change_dat, mp.load_id, mp.approval_user, mp.entry_user
        FROM (
            SELECT
                'RENAME_SEC' AS change_type,
                @SECURITY_ROLE_DESC_OLD AS attribute_frst,
                @SECURITY_ROLE_DESC_NEW AS attribute_scnd,
                NULL AS change_type_value,
                CURRENT_DATE() AS change_dat,
                lid.load_id AS load_id,
                @ENTRY_USER AS approval_user,
                @ENTRY_USER AS entry_user
            FROM (
                SELECT MAX(load_id) AS load_id
                FROM `p_lew_mart_msi.t_sys_load_status_acl_1`
            ) AS lid
        ) AS mp
    ''';
    EXECUTE IMMEDIATE (sql_stmt) 
        USING SECURITY_ROLE_DESC_OLD AS SECURITY_ROLE_DESC_OLD, 
              SECURITY_ROLE_DESC_NEW AS SECURITY_ROLE_DESC_NEW, 
              ENTRY_USER AS ENTRY_USER;

    COMMIT TRANSACTION;
END;