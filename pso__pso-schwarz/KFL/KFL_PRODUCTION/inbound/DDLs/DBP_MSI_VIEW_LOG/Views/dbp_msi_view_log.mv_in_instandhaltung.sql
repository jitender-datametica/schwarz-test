CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_INSTANDHALTUNG(
	AUFTRAG_ID,
	MANDANT_ID,
	INSTANDHALTUNG_LEISTUNGSART_ID,
	IN_KUNDE_ID,
	QUAL_MELDUNG_ID,
	WART_PLAN_ID,
	WART_PLAN_ABRUF_ID,
	WART_PLAN_POS_ID,
	DAT_BEZUG,
	AUFTRAG_AUS_WARTUNG,
	WARTUNG_FG,
	AUSFALL_FG,
	AUFTRAGSTYP_ID
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial, based on LIS + logic for auftragstyp_id
--2022-08-19, AP0133256,SPEC0166769,dknop, correcting logic for auftragstyp_id
  SELECT
   v01.auftrag_id
   ,v01.mandant_id
   ,v01.instandhaltung_leistungsart_id
   ,v01.in_kunde_id
   ,v01.qual_meldung_id
   ,v01.wart_plan_id
   ,v01.wart_plan_abruf_id
   ,v01.wart_plan_pos_id
   ,v01.dat_bezug
   ,CASE WHEN v01.wart_plan_id IS NULL THEN 'nein' ELSE 'ja' END auftrag_aus_wartung
   ,CASE WHEN v01.wart_plan_id > 0 THEN 1 ELSE 0 END AS wartung_fg
   ,CASE WHEN v02.ausfall_fg = 1 THEN 1 ELSE 0 END AS ausfall_fg
   ,CASE WHEN wartung_fg=0 AND ausfall_fg=0 THEN 0
         WHEN wartung_fg=1 AND ausfall_fg=0 THEN 1
         WHEN wartung_fg=0 AND ausfall_fg=1 THEN 2
         WHEN wartung_fg=1 AND ausfall_fg=1 THEN 3 
         ELSE '-1' END AS auftragstyp_id
   FROM dbp_view.v_in_instandhaltung v01
   LEFT JOIN dbp_data.in_qual_instand v02 
      ON v01.qual_meldung_id=v02.qual_meldung_id
      AND v01.mandant_id=v02.mandant_id;