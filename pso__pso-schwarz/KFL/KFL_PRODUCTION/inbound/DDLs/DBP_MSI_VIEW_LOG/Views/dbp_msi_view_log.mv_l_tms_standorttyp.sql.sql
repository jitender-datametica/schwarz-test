CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_STANDORTTYP(
	TMS_STANDORTTYP_ID,
	TMS_STANDORTTYP_LFD_NR,
	TMS_STANDORTTYP_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial
--2025-01-29, nwag, prio KTMS_DE > KTMS_FLW_DE
SELECT
 tms_standorttyp_id
,tms_standorttyp_lfd_nr
,tms_standorttyp_bez

FROM dbp_view.v_l_tms_standorttyp t0
JOIN dbp_view.v_l_system s
  ON t0.system_id = s.system_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY tms_standorttyp_id, tms_standorttyp_lfd_nr, tms_standorttyp_bez ORDER BY CASE WHEN LEFT(KL_SYSTEM_BEZ,3)  <> 'FLW' THEN 0 ELSE 1 END) = 1

UNION
SELECT
 '-1'
,'-1'
,'n/a'
;
