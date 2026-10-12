create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_ODS_BON_KOPF(
	BON_ID,
	BON_DAT,
	MANDANT_ID,
	WUP_ID,
	KASSE_TYP_ID,
	KUNDENKARTE_TYP_ID,
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
	REACTIVATED_FG,
	PERSONAL_ID,
	BETRAG_PERSONAL_RABATT,
	KPOS_KASSE_TYP,
	WAGEN_NR,
	KUNDENKARTE_ID,
	DRUECKEN_SUMMENTASTE,
	SCHLIESSEN_KASSENSCHUBLADE,
	FISKALISIERUNG_FG,
	BON_NR_FISCAL,
	ALTERNATIVE_KARTE_ID,
	SUSPENDED_FG,
	SUSPENDED_BON_NR
) as






    SELECT 
      v01.bon_id
    , v01.bon_dat
    , v01.mandant_id
    , v02.aktuell_wup_id AS wup_id
    , v01.kasse_typ_id
    , v01.kundenkarte_typ_id
    , v01.bon_nr
    , v01.kasse_nr
    , v01.kassierer_nr
    , v01.kunde_fg
    , v01.bon_beginn
    , v01.bon_ende
    , v01.umsatz_mwst
    , v01.umsatz_brutto
    , v01.bon_booking
    , v01.dat_booking
    , v01.turnover_fg
    , v01.wrg_id
    , v01.reactivated_fg
    , v01.personal_id
    , v01.betrag_personal_rabatt
    , v01.kpos_kasse_typ
    , v01.wagen_nr
    , v01.kundenkarte_id
    , v01.druecken_summentaste
    , v01.schliessen_kassenschublade
    , v01.fiskalisierung_fg
    , v01.bon_nr_fiscal
    , v01.alternative_karte_id
    , v01.suspended_fg
    , v01.suspended_bon_nr	
	FROM DBP_V_ODS.V_ODS_BON_KOPF v01
	
INNER JOIN dbp_view.v_wup v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;