CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WBS_AUSLIEFERGRUPPE_BERECHNUNGSLAUF_2(
	MANDANT_ID,
	AUSLIEFERGRUPPE_ID,
	BERECHNUNGSPROZESS_ID,
	BERECHNUNGSLAUF_NR,
	ZEITSLOT_ID
) AS
--2025-03-18, AP0245125 , dknop, initial
SELECT 
 v1.mandant_id
,v1.ausliefergruppe_id
,v1.berechnungsprozess_id
,v1.berechnungslauf_nr
,v1.zeitslot_id
--,CASE WHEN v1.berechnungslauf_nr = 2 THEN v1.zeitslot_id ELSE NULL END AS zeitslot_id_2_ab

FROM dbp_msi_v_view.v_ts_wbs_ausliefergruppe_berechnungslauf_2 v1


;