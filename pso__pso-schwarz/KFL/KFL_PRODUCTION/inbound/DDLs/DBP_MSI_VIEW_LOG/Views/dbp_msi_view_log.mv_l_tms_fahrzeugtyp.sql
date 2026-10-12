CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_FAHRZEUGTYP(
	TMS_FAHRZEUGTYP_ID,
	TMS_FAHRZEUGTYP_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial
--2025-01-29, nwag, prio KTMS_DE > KTMS_FLW_DE
SELECT
t0.tms_fahrzeugtyp_id
,t0.tms_fahrzeugtyp_bez
FROM dbp_view.v_l_tms_fahrzeugtyp t0
JOIN dbp_view.v_l_system s
  ON t0.system_id = s.system_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY tms_fahrzeugtyp_id ORDER BY CASE WHEN LEFT(KL_SYSTEM_BEZ,3)  <> 'FLW' THEN 0 ELSE 1 END) = 1
;