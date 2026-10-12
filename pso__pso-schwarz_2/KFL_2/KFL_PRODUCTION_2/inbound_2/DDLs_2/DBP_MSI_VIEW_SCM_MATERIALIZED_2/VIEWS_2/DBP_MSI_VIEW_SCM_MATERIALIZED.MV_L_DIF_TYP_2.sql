create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_DIF_TYP_2(
	DIF_TYP_ID
) as

SELECT
dif_typ_id
FROM dbp_view.v_l_dif_typ_2;