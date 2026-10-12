create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_UDF_PROGNOSE_WHATIF_2(
	MANDANT_ID,
	ART_ID,
	NB_ID,
	WUP_ID,
	ANGEBOT_ID,
	DAT_VON,
	DAT_BIS,
	MENGE_PROGNOSE_BASIS,
	MENGE_PROGNOSE_SAISON,
	MENGE_PROGNOSE_FEIERTAG,
	MENGE_PROGNOSE_PREISAENDERUNG,
	MENGE_PROGNOSE_KAUFANREIZE,
	MENGE_PROGNOSE_UPLIFT,
	MENGE_PROGNOSE_WERBEMITTEL,
	MENGE_PROGNOSE_PRAEMIENKAUFANREIZE,
	MENGE_PROGNOSE_KUNDENKARTE,
	MENGE_PROGNOSE_VERFUEGBARKEIT,
	MENGE_PROGNOSE_FAKTOREN,
	MENGE_PROGNOSE_GESAMT,
	DAT_ERSTELLUNG,
	DAT_BELADUNG,
	DAT_PROGNOSE_WERBUNG_ZULETZT_GESTEUERT,
	PROGNOSE_OFFER_NULLWERT_FG,
	PROGNOSE_PREIS_NULLWERT_FG,
	PROGNOSE_PREIS_FAKTOR_FG,
	PROGNOSE_TACTIC_NULLWERT_FG,
	MENGE_PROGNOSE_FAKTOR_FG,
	MENGE_PROGNOSE_NULLWERT_FG,
	QUELLE_ALT_PRIOREN_FG,
	DAT_PROGNOSE_NORMAL_ZULETZT_GESTEUERT,
	ANZ_PRIOR_GESAMT,
	ANZ_PRIOR_EIGEN,
	ANZ_PRIOR_REF,
	ANZ_PRIOR_HPR,
	ANZ_PRIOR_DEFAULT,
	KJWO
) as






WITH TOP_DAT_BERECHNUNG AS (
        SELECT  DISTINCT TOP 5 dat_beladung 
        FROM DBP_VIEW.V_UDF_PROGNOSE_WHATIF_2 ORDER BY  dat_beladung DESC
)
SELECT
	v01.mandant_id
	,v01.art_id
	,v01.nb_id
	
    
	,v05.aktuell_wup_id wup_id
	,v01.angebot_id
	,v01.dat_von
	,v01.dat_bis
	,v01.menge_prognose_basis
	,v01.menge_prognose_saison
	,v01.menge_prognose_feiertag
	,v01.menge_prognose_preisaenderung
	,v01.menge_prognose_kaufanreize
	,v01.menge_prognose_uplift
	,v01.menge_prognose_werbemittel
	,v01.menge_prognose_praemienkaufanreize
	,v01.menge_prognose_kundenkarte
	,v01.menge_prognose_verfuegbarkeit
	,v01.menge_prognose_faktoren
	,v01.menge_prognose_gesamt
	,v01.dat_erstellung
	,CASE WHEN v01.mandant_id IN (4,7) AND v01.dat_beladung<>CURRENT_DATE THEN v01.dat_beladung +1 ELSE v01.dat_beladung END AS dat_beladung_
	
	
    ,v01.dat_prognose_werbung_zuletzt_gesteuert 
	,v01.prognose_offer_nullwert_fg
	,v01.prognose_preis_nullwert_fg
	,v01.prognose_preis_faktor_fg
	,v01.prognose_tactic_nullwert_fg
	,v01.menge_prognose_faktor_fg
	,v01.menge_prognose_nullwert_fg
	
    ,v01.quelle_alt_prioren_fg
    ,v01.dat_prognose_normal_zuletzt_gesteuert
    ,v01.anz_prior_gesamt
    ,v01.anz_prior_eigen
    ,v01.anz_prior_ref
    ,v01.anz_prior_hpr
    ,v01.anz_prior_default
	
	,v02.kjwo
FROM DBP_VIEW.V_UDF_PROGNOSE_WHATIF_2 v01
INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id
   
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

JOIN DBP_VIEW.V_TAG_2 v02
ON (v01.dat_von = v02.dat)
JOIN TOP_DAT_BERECHNUNG v99
ON dat_beladung_ = v99.dat_beladung;
