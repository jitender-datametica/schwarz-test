create or replace view IDQ_PRODUCTION.DWH.MSTR_CUBE_SYSTEM_PROCESS_1(
	SYSTEM_PROCESS_MSTR_CUBE,
	SYSTEM_PROCESS_ID,
	SYSTEM_PROCESS,
	CUBE_ID,
	MSTR_CUBE_NAME,
	REF_SOURCE_SYSTEM_TYPE_ID
) as
SELECT
    spmc.ID                              AS SYSTEM_PROCESS_MSTR_CUBE
    ,spmc.SYSTEM_PROCESS_ID
    ,sp.name                             AS SYSTEM_PROCESS
    ,spmc.CUBE_ID                        AS CUBE_ID
	,mc.MSTR_CUBE_NAME
    ,mc.REF_SOURCE_SYSTEM_TYPE_ID          AS REF_SOURCE_SYSTEM_TYPE_ID

FROM SCHEDULER.SYSTEM_PROCESS_MSTR_CUBE spmc
join dwh.mstr_cube_1 mc
on (mc.cube_id = spmc.cube_id)
join scheduler.system_process sp
on (sp.id = spmc.system_process_id)
;