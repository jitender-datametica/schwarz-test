CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WERBEFLAECHENTHEMA_AVQ(
	MANDANT_ID,
	WERBEFLAECHENTHEMA_AVQ_PRIO,
	WERBEFLAECHENTHEMA_AVQ_BEZ
) AS
--2025-08-25, dknop, AP0269651, SPEC0329583, initial
SELECT 
 mandant_id
,werbeflaechenthema_avq_prio_nr
, werbeflaechenthema_avq_prio_bez
FROM dbp_view.v_l_werbeflaechenthema_avq_prio;