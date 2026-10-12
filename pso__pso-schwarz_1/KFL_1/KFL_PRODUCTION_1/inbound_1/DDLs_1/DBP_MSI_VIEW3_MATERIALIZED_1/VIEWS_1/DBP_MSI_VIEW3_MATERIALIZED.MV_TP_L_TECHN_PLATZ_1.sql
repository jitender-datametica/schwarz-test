create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TP_L_TECHN_PLATZ_1(
	TECHN_PLATZ_ID
) as
   SELECT
   v01.techn_platz_id
   FROM dbp_view.v_tp_l_techn_platz_1 v01;