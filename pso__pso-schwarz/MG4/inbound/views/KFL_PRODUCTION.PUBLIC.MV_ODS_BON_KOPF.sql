create or replace view KFL_PRODUCTION.PUBLIC.MV_ODS_BON_KOPF(
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
	KASSE_TYP_ID,
	ZEITSTEMPEL_DRUCK
) as
   
   

   SELECT
   k.bon_id, k.bon_dat, k.wup_id, 0 as nb_id, k.mandant_id, k.bon_nr, k.kasse_nr, k.kassierer_nr, k.kunde_fg, k.bon_beginn, k.bon_ende, k.umsatz_mwst, k.umsatz_brutto, k.bon_booking, k.dat_booking, k.turnover_fg, k.wrg_id, k.kasse_typ_id, COALESCE (a.zeitstempel_druck, ('9999-12-31 23:59:59'::TIMESTAMP))  zeitstempel_druck
   FROM dbp_v_ods.v_ods_bon_kopf k
   LEFT OUTER JOIN dbp_msi_v_view.v_ods_bon_abhol_liste a
   ON k.bon_id      = a.bon_id
   AND k.mandant_id = a.mandant_id
   AND k.wup_id     = a.wup_id;