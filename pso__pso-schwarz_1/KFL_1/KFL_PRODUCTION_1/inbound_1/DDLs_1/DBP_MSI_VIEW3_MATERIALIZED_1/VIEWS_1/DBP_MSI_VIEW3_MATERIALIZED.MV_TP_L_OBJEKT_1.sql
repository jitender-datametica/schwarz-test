create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TP_L_OBJEKT_1(
	MANDANT_ID,
	TP_OBJEKT_ID
) as
   SELECT
   v01.mandant_id, v01.tp_objekt_id
   FROM dbp_view.v_tp_l_objekt_1 v01;