CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_TOUR_STATUS_BELOG_1(
	MANDANT_ID,
	TMS_TOURSTATUS_ID,
	TMS_TOURSTATUS_LFD_NR,
	TMS_TOURSTATUS_BEZ
) AS
--2025-05-12, nwag, initial
SELECT 
 t0.mandant_id
,t0.tms_tourstatus_id
,t0.tms_tourstatus_lfd_nr
,t0.tms_tourstatus_bez
FROM dbp_view.v_l_tms_tourstatus_1 t0
JOIN dbp_view.v_l_system_1 s
  ON t0.system_id = s.system_id
  AND s.system_gruppe = 'WANKO BELOG'
;