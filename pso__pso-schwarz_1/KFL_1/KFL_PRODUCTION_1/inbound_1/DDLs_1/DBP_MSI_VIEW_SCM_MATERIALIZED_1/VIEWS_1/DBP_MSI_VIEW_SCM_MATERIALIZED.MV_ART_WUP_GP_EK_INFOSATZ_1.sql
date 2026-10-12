create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_WUP_GP_EK_INFOSATZ_1(
	MANDANT_ID,
	GP_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	RUNDUNGSPROFIL,
	PLANLIEFERZEIT,
	MIND_BESTELLMENGE
) as
SELECT
 v01.mandant_id
,v01.gp_id
,v01.art_id
,v02.wup_id
,v02.nb_id
,v02.rundungsprofil
,v02.planlieferzeit
,v02.mind_bestellmenge
FROM DBP_VIEW.v_ek_infosatz_1 v01
JOIN DBP_VIEW.v_ek_infosatz_wup_zu_1 v02 
  ON v01.mandant_id     = v02.mandant_id
 AND v01.ek_infosatz_id = v02.ek_infosatz_id
WHERE v02.nb_id = -111
  AND v01.dat_bis = '9999-12-31'
  AND v01.loesch_fg = 0;