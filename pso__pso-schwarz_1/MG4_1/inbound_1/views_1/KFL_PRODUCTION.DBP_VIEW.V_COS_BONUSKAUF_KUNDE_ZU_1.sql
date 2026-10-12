create or replace view KFL_PRODUCTION.DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU_1(
	BONUSKAUF_ID,
	MANDANT_ID,
	CRM_KUNDE_ID,
	KAUF_ID,
	ANZ_EINLOESUNG,
	WRG_ID,
	DAT_KAUF_RUECKGABE,
	DAT_KAUF,
	KAUF_STATUS_NR,
	ANZ_KAUFBAR,
	DAT_KAUF_EINLOESUNG,
	STATUS_AKTIV_NR,
	DATZEIT_STATUS_AKTIVIERUNG,
	STATUS_EINLOESUNG,
	DAT_STATUS_EINLOESUNG,
	KONTROLLGRUPPE,
	KAMPAGNEN_ID,
	CHECKOUT_FG,
	ANZ_KAUF_IST,
	ANZ_KAUF_SOLL,
	SUM_KAUF_IST,
	SUM_KAUF_SOLL,
	DAT_UPDATE,
	KAMPAGNEN_VERSION
) as 
    SELECT 
        bonuskauf_id
        ,mandant_id
        ,crm_kunde_id
        ,kauf_id
        ,anz_einloesung
        ,wrg_id
        ,dat_kauf_rueckgabe
        ,dat_kauf
        ,kauf_status_nr
        ,anz_kaufbar
        ,dat_kauf_einloesung
        ,status_aktiv_nr
        ,datzeit_status_aktivierung
        ,status_einloesung
        ,dat_status_einloesung
        ,kontrollgruppe
        ,kampagnen_id
        ,checkout_fg
        ,anz_kauf_ist
        ,anz_kauf_soll
        ,sum_kauf_ist
        ,sum_kauf_soll
        ,dat_update
        ,kampagnen_version


FROM DBP_DATA.COS_BONUSKAUF_KUNDE_ZU_1 ;