create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ODS_BON_F_VERKAUF_2(
	BON_ID,
	BON_DAT,
	BON_BOOKING,
	DAT_BOOKING,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	KASSE_NR,
	KUNDE_FG,
	BON_BEGINN,
	BON_ENDE,
	TURNOVER_FG,
	WRG_ID,
	KASSE_TYP_ID,
	BON_ZEILE,
	KL_ART_ID,
	ART_ID,
	EAN_KASSE,
	MENGE,
	EINH_ID,
	UMSATZ_BRUTTO,
	KPOS_ERFASSUNG_ID,
	MWST
) as









SELECT
k.bon_id
, k.bon_dat
, k.bon_booking
, k.dat_booking


, v05.aktuell_wup_id wup_id 
,0 AS nb_id
, k.mandant_id
, k.kasse_nr
, k.kunde_fg
, k.bon_beginn
, k.bon_ende
, k.turnover_fg


, CASE WHEN user_wrg.wrg_typ_id = 0 THEN kurs.nach_wrg_id ELSE man.default_wrg END AS wrg_id
, k.kasse_typ_id
, v.bon_zeile
, v.kl_art_id
, a.art_id
, v.ean_kasse

, v.menge
, v.einh_id

, CASE WHEN k.wrg_id <> 'EUR' AND man.default_wrg = 'EUR' 
    THEN v.umsatz_brutto * kurs.umrechnungskurs  
    WHEN user_wrg.wrg_typ_id=0 THEN v.umsatz_brutto*kurs.umrechnungskurs ELSE v.umsatz_brutto END AS umsatz_brutto
, v.kpos_erfassung_id
, m.mwst



FROM dbp_v_ods.v_ods_bon_kopf_2 k

INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = k.mandant_id
   
   AND v05.wup_id = k.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))


INNER JOIN dbp_v_ods.v_ods_bon_verkauf_2 v
ON k.bon_id = v.bon_id
AND k.wup_id = v.wup_id
AND k.mandant_id = v.mandant_id
AND k.bon_dat = v.bon_dat
AND v.wg_id <> 961

INNER JOIN dbp_view.v_mwst_per_2 m
ON v.mandant_id = m.mandant_id
AND v.mwst_id = m.mwst_id
AND v.bon_dat BETWEEN m.dat_von AND m.dat_bis 

INNER JOIN dbp_view.v_art_2 a
ON v.kl_art_id = a.kl_art_id
AND v.mandant_id = a.mandant_id


JOIN dbp_view.v_mandant_2 man
ON k.mandant_id = man.mandant_id

JOIN DBP_MSI_VIEW_SCM_MATERIALIZED.mv_kurs_2 kurs_2
ON k.wrg_id = kurs.von_wrg_id

CROSS JOIN DBP_MSI_VIEW_SCM_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 user_wrg

WHERE (k.bon_id, k.wup_id, k.mandant_id) NOT IN
(
SELECT bon_id, wup_id, mandant_id
FROM dbp_v_ods.v_ods_bon_storno_2
);