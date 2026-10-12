create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_BONUSKAUF_2(
	MANDANT_ID,
	BONUSKAUF_ID,
	BONUSKAUF_BEZ,
	ZEIT_VON,
	ZEIT_BIS,
	KONDITIONSART_ID,
	GESCHAEFTSVORFALL_ID,
	DAT_VON,
	DAT_BIS,
	AKTION_ID,
	SPR_ID
) as

SELECT
 v01.mandant_id
,v01.bonuskauf_id
,v03.bonuskauf_bez



,v01.zeit_von
,v01.zeit_bis
,v01.konditionsart_id
,v01.geschaeftsvorfall_id
,v01.dat_von
,v01.dat_bis
,v01.aktion_id
,v03.spr_id

FROM dbp_view.v_l_bonuskauf_2 v01

JOIN dbp_view.v_bonuskauf_spr_zu_2 v03
ON v01.bonuskauf_id = v03.bonuskauf_id
AND v01.mandant_id = v03.mandant_id;