-- SP_MANAGE_TOOLBOX_RIGHTS_UPDATE (STRING , NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER, NUMBER)



CREATE OR REPLACE PROCEDURE idq_results.sp_manage_toolbox_rights_update(IN MSTR_USER STRING, IN SYSCHECK_EXCLUDE_FLAG INT64, IN SYSCHECK_PARAMETER_FLAG INT64, IN SYSCHECK_ALERTS_FLAG INT64, IN SYSCOMP_EXCLUDE_FLAG INT64, IN SYSCOMP_PARAMETER_FLAG INT64, IN SYSCOMP_ALERTS_FLAG INT64, IN RELEVANCE_EXCLUDE_FLAG INT64, IN RELEVANCE_PARAMETER_FLAG INT64, IN RELEVANCE_ALERTS_FLAG INT64, IN RULE_CATALOG_FLAG INT64, IN TOOLBOX_ADMIN_FLAG INT64, IN MAIL_KFL_EK_NR_FLAG INT64, IN MAIL_SP_FLAG INT64)
BEGIN
BEGIN TRANSACTION;
IF SYSCHECK_EXCLUDE_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    syscheck_exclude_flag = SYSCHECK_EXCLUDE_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF SYSCHECK_PARAMETER_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    syscheck_parameter_flag = SYSCHECK_PARAMETER_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF SYSCHECK_ALERTS_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    syscheck_alerts_flag = SYSCHECK_ALERTS_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF SYSCOMP_EXCLUDE_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    syscomp_exclude_flag = SYSCOMP_EXCLUDE_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF SYSCOMP_PARAMETER_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    syscomp_parameter_flag = SYSCOMP_PARAMETER_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF SYSCOMP_ALERTS_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    syscomp_alerts_flag = SYSCOMP_ALERTS_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF RELEVANCE_EXCLUDE_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    relevance_exclude_flag = RELEVANCE_EXCLUDE_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF RELEVANCE_PARAMETER_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    relevance_parameter_flag = RELEVANCE_PARAMETER_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF RELEVANCE_ALERTS_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    relevance_alerts_flag = RELEVANCE_ALERTS_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF RULE_CATALOG_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    rule_catalog_flag = RULE_CATALOG_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF RULE_CATALOG_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    rule_catalog_flag = RULE_CATALOG_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF TOOLBOX_ADMIN_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    toolbox_admin_flag = TOOLBOX_ADMIN_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF MAIL_KFL_EK_NR_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    mail_kfl_ek_nr_flag = MAIL_KFL_EK_NR_FLAG
WHERE mstr_user = MSTR_USER;
END IF;


IF MAIL_SP_FLAG IS NOT NULL THEN
    UPDATE idq_results.ref_toolbox_execution_rights_1 SET
    mail_sp_flag = MAIL_SP_FLAG
WHERE mstr_user = MSTR_USER;
END IF;

COMMIT TRANSACTION;
END;
