CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_TREIBSTOFF(
	MANDANT_ID,
	TMS_TREIBSTOFF_ID,
	TMS_TREIBSTOFF_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial
--2025-01-29, nwag, prio KTMS_DE > KTMS_FLW_DE
SELECT
 t0.mandant_id
,t0.tms_treibstoff_id
,t0.tms_treibstoff_bez
FROM dbp_view.v_l_tms_treibstoff t0
JOIN dbp_view.v_l_system s
  ON t0.system_id = s.system_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY t0.mandant_id, t0.tms_treibstoff_id ORDER BY CASE WHEN LEFT(KL_SYSTEM_BEZ,3)  <> 'FLW' THEN 0 ELSE 1 END) = 1;