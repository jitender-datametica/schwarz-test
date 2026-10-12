CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_ART_LAGERPLATZ_EWM(
	LAGERNUMMER_ID,
	MANDANT_ID,
	DAT,
	ART_ID,
	ART_GUID,
	WUP_ID,
	NB_ID,
	LAGERTYP_ID,
	LAGERPLATZ_ID,
	ARTIKELSORTIMENT_ID,
	MENGE_FIXIERT,
	TR_FG,
	TKL_FG
) AS
--2022-03-23, AP0124952, SPEC0149061, dknop, initial

SELECT
 a_lp.lagernummer_id
,a_lp.mandant_id
,t.dat
,a_lp.art_id
,a_lp.art_guid
,a_lp.wup_id
,a_lp.nb_id
,a_lp.lagertyp_id
,a_lp.lagerplatz_id
,a_sort.artikelsortiment_id
,a_lp.menge_fixiert_fg
,a_lp.tr_fg 
,a_lp.tkl_fg
	
FROM dbp_view.v_art_lagerplatz_per_ewm a_lp

JOIN dbp_view.v_tag t 
ON t.dat BETWEEN a_lp.dat_von AND a_lp.dat_bis

JOIN dbp_view.v_art_wup_status_per marc 
ON a_lp.mandant_id = marc.mandant_id 
AND a_lp.art_id = marc.art_id
AND a_lp.wup_id = marc.wup_id
AND marc.dat_bis='9999-12-31'

JOIN  dbp_view.v_fremd_lagerort_artikelsortiment_zu a_sort
ON marc.fremd_lagerort_id = a_sort.fremd_lagerort_id
AND marc.mandant_id=a_sort.mandant_id

--where t.dat='2022-03-01'
;