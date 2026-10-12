create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_PALETTEN_KONTROLLE_GEWICHT_1(
	MANDANT_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	HANDLING_UNIT_ID,
	HANDLING_UNIT_ID_TRAEGER,
	STATUS_ID,
	GEWICHT_IST,
	GEWICHT_SOLL,
	GEWICHT_ABWEICHUNG
) as
   SELECT
  v01.mandant_id,
   v01.lagernummer_id,
   v01.wup_id,
   v01.nb_id,
   v01.handling_unit_id,
   v01.handling_unit_id_traeger,
   v01.status_id,
   v01.gewicht_ist,
   v01.gewicht_soll,
   CASE WHEN CAST(v01.gewicht_ist AS DECIMAL(18,5)) > 0.00000 THEN ( ABS(CAST(v01.gewicht_ist AS DECIMAL(18,5))- CAST(v01.gewicht_soll AS DECIMAL(18,5))) / CAST(v01.gewicht_soll AS DECIMAL(18,5)))ELSE NULL END AS gewicht_abweichung

   FROM dbp_view.v_paletten_kontrolle_gewicht_1 v01;