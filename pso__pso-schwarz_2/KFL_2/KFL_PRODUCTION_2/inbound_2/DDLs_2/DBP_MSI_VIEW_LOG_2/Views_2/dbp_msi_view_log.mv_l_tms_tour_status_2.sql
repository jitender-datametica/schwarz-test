CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_TOUR_STATUS_2(
	MANDANT_ID,
	TMS_TOURSTATUS_ID,
	TMS_TOURSTATUS_LFD_NR,
	TMS_TOURSTATUS_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial
--2025-01-29, nwag, prio KTMS_DE > KTMS_FLW_DE
--2025-05-12, nwag, remove BELOG records
SELECT 
 t0.mandant_id
,t0.tms_tourstatus_id
,t0.tms_tourstatus_lfd_nr
,t0.tms_tourstatus_bez
FROM dbp_view.v_l_tms_tourstatus_2 t0
JOIN dbp_view.v_l_system_2 s
  ON t0.system_id = s.system_id
  AND s.system_gruppe <> 'WANKO BELOG'
QUALIFY ROW_NUMBER() OVER (PARTITION BY t0.mandant_id, t0.tms_tourstatus_id,t0.tms_tourstatus_lfd_nr ORDER BY CASE WHEN LEFT(KL_SYSTEM_BEZ,3)  <> 'FLW' THEN 0 ELSE 1 END) = 1
;