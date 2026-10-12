CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WERBEMITTEL_AVQ_2(
	MANDANT_ID,
	WERBEMITTEL_AVQ_PRIO,
	WERBEMITTEL_AVQ_BEZ
) AS
--2025-08-25, dknop, AP0269651, SPEC0329583, initial
SELECT 
 mandant_id
,werbemittel_avq_prio_nr
,werbemittel_avq_prio_bez
FROM dbp_view.v_l_werbemittel_avq_prio_2;
