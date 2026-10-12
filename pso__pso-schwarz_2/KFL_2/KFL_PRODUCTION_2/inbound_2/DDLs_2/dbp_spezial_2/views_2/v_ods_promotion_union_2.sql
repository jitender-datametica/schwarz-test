create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_PROMOTION_UNION_2(
	MANDANT_ID,
	BON_ID,
	WUP_ID,
	BON_ZEILE,
	BONUSKAUF_ID,
	KONDITIONSART_ID,
	PROMOTION_LFD_NR,
	BETRAG_PROMO_BRUTTO,
	KL_ART_ID,
	START_BON_ZEILE,
	MENGE_PROMO,
	UMSATZ_PROMO_BRUTTO,
	BON_DAT,
	CUSTOMER_PROMOTION_FG,
	PROMOTION_ART
) as 
SELECT mandant_id
,bon_id
,wup_id
,bon_zeile
,bonuskauf_id
,konditionsart_id
,promotion_lfd_nr
,betrag_promo_brutto
,kl_art_id
,start_bon_zeile
,menge_promo
,umsatz_promo_brutto
,bon_dat
,customer_promotion_fg
,promotion_art
FROM dbp_ods.ods_promotion_2
UNION ALL
SELECT mandant_id
,bon_id
,wup_id
,bon_zeile
,bonuskauf_id
,konditionsart_id
,promotion_lfd_nr
,betrag_promo_brutto
,kl_art_id
,start_bon_zeile
,menge_promo
,umsatz_promo_brutto
,bon_dat
,0 as customer_promotion_fg
,'' as promotion_art
FROM dbp_ods_archiv.ods_promotion_2;