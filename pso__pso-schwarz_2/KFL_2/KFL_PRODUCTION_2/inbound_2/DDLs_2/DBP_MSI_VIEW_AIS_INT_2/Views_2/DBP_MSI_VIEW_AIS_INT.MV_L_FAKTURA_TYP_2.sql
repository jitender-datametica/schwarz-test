CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_FAKTURA_TYP_2(
	MANDANT_ID,
	FAKTURA_TYP_ID,
	RETOURE_FG
) AS
   -- 06.03.2024: SPEC0235522, Neuanlage
   SELECT
   v01.mandant_id, v01.faktura_typ_id, CASE WHEN v01.faktura_typ_id IN ('O','S') THEN 1 ELSE 0 END AS retoure_fg

   FROM dbp_view.v_besch_faktura_2 v01
   WHERE  v01.mandant_id = 1

   GROUP BY 1,2;