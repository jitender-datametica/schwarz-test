create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_EK_INFOSATZ_WUP_ZU_1(
	MANDANT_ID,
	EK_INFOSATZ_ID,
	WUP_ID,
	NB_ID,
	PROZENT_AKZEPTANZ_UNTERLIEF
) as
   SELECT
  mandant_id, ek_infosatz_id, wup_id, nb_id, prozent_akzeptanz_unterlief

   FROM dbp_view.v_ek_infosatz_wup_zu_1;