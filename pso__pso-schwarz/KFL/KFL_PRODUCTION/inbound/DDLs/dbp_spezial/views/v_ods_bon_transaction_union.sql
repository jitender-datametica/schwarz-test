create or replace view KFL_PRODUCTION.DBP_SPEZIAL.v_ods_bon_transaction_union(
	BON_ID,
	BON_DAT,
	WUP_ID,
	MANDANT_ID,
	KASSE_NR,
	BON_BEGINN,
	DATEI_NAME,
	KASSIERER_NR,
	CANCEL_FG,
	TRANSACTION_NAME,
	BON_NR,
	BON_ENDE,
	BON_BOOKING,
	SUSPENDED_FG,
	TRAINING_FG,
	KASSE_TYP_ID,
	KPOS_KASSE_TYP,
	KASSENSYSTEM_NAME,
	KPOS_TRANSACTION_NAME,
	KPOS_TRANSACTION_STATUS,
	DAT_BOOKING
) as 
SELECT bon_id
,bon_dat
,wup_id
,mandant_id
,kasse_nr
,bon_beginn
,datei_name
,kassierer_nr
,cancel_fg
,transaction_name
,bon_nr
,bon_ende
,bon_booking
,suspended_fg
,training_fg
,kasse_typ_id
,kpos_kasse_typ
,kassensystem_name
,kpos_transaction_name
,kpos_transaction_status
,dat_booking
 FROM dbp_ods.ods_bon_transaction
UNION ALL
SELECT bon_id
,bon_dat
,wup_id
,mandant_id
,kasse_nr
,bon_beginn
,datei_name
,kassierer_nr
,cancel_fg
,transaction_name
,bon_nr
,bon_ende
,bon_booking
,suspended_fg
,training_fg
,kasse_typ_id
,kpos_kasse_typ
,kassensystem_name
,kpos_transaction_name
,kpos_transaction_status
,dat_booking
 FROM dbp_ods_archiv.ods_bon_transaction;