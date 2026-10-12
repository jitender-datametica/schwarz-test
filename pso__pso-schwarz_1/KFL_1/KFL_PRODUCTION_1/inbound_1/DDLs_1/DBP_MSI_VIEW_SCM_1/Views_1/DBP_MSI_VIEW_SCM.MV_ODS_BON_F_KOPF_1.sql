CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ODS_BON_F_KOPF_1(
	BON_ID,
	BON_DAT,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	BON_NR,
	KASSE_NR,
	KASSIERER_NR,
	KUNDE_FG,
	BON_BEGINN,
	BON_ENDE,
	UMSATZ_MWST,
	UMSATZ_BRUTTO,
	BON_BOOKING,
	DAT_BOOKING,
	TURNOVER_FG,
	WRG_ID,
	KASSE_TYP_ID
) AS
   -- Fakt-View z.B. fÃ¼r Kassierzeit
   -- Gefiltert, d.h. nur nicht stornierte Bons enthalten
   --2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
      SELECT
   bon_id, bon_dat, 
   --wup_id, 
   --CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id,
   v05.aktuell_wup_id ,
   0 AS nb_id, v01.mandant_id, bon_nr, kasse_nr, kassierer_nr, kunde_fg, bon_beginn, bon_ende, umsatz_mwst, umsatz_brutto, bon_booking, dat_booking, turnover_fg, wrg_id, kasse_typ_id
   FROM dbp_v_ods.v_ods_bon_kopf_1 v01
   INNER JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id =  v01.mandant_id
   --AND v05.wup_id = CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v01.wup_id AS INTEGER) END
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

   WHERE (bon_id, v01.wup_id, v01.mandant_id) NOT IN
   (SELECT bon_id, wup_id, mandant_id
   FROM dbp_v_ods.v_ods_bon_storno_1
   );