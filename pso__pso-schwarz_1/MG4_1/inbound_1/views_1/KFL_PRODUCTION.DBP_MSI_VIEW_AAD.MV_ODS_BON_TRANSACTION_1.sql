create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_ODS_BON_TRANSACTION_1(
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
	DAT_BOOKING,
	BON_NR_FISCAL
) as





    SELECT 
      v01.bon_id
    , v01.bon_dat
    , v02.aktuell_wup_id AS wup_id
    , v01.mandant_id
    , v01.kasse_nr
    , v01.bon_beginn
    , v01.datei_name
    , v01.kassierer_nr
    , v01.cancel_fg
    , v01.transaction_name
    , v01.bon_nr
    , v01.bon_ende
    , v01.bon_booking
    , v01.suspended_fg
    , v01.training_fg
    , v01.kasse_typ_id
    , v01.kpos_kasse_typ
    , v01.kassensystem_name
    , v01.kpos_transaction_name
    , v01.kpos_transaction_status
    , v01.dat_booking
    , v01.bon_nr_fiscal
	FROM DBP_V_ODS.V_ODS_BON_TRANSACTION_1 v01
	
INNER JOIN dbp_view.v_wup_1 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;