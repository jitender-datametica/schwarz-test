CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WERBEFLAECHE_ABSCHNITT_AVQ_2(
	MANDANT_ID,
	WERBEFLAECHENABSCHNITT_AVQ_PRIO,
	WERBEFLAECHENABSCHNITT_AVQ_BEZ
) AS
--2025-08-25, dknop, AP0269651, SPEC0329583, initial
SELECT 
 mandant_id
,werbeflaechenabschnitt_avq_prio_nr
,werbeflaechenabschnitt_avq_prio_bez
FROM dbp_view.v_l_werbeflaechenabschnitt_avq_prio_2;