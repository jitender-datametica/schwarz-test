CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_SORTIMENT_1(
	TMS_SORTIMENT_ID,
	TMS_SORTIMENT_LFD_NR,
	TMS_SORTIMENT_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial
--2025-01-29, nwag, prio KTMS_DE > KTMS_FLW_DE
SELECT 
 tms_sortiment_id
,tms_sortiment_lfd_nr
,tms_sortiment_bez
FROM dbp_view.v_l_tms_sortiment_1 t0
JOIN dbp_view.v_l_system_1 s
  ON t0.system_id = s.system_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY  tms_sortiment_id, tms_sortiment_lfd_nr ORDER BY CASE WHEN LEFT(KL_SYSTEM_BEZ,3)  <> 'FLW' THEN 0 ELSE 1 END) = 1

UNION

SELECT
 -1
,-1
, 'not defined'
;