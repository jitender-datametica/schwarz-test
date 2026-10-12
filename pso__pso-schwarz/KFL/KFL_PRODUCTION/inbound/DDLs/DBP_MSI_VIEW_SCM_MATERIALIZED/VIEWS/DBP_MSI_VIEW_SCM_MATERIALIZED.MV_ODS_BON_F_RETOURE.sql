create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ODS_BON_F_RETOURE(
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
	TEST,
	UMSATZ_BRUTTO,
	MWST,
	REKLAMATIONSGRUND_ID,
	REKLAMATIONSTYP_ID,
	MENGE_FG,
	MHD,
	LOS_CHARGE,
	KUNDEN_TEXT,
	ART_ID_REF,
	KPOS_ERFASSUNG_ID
) as








SELECT
k.bon_id
, k.bon_dat
, k.bon_booking
, k.dat_booking


,v05.aktuell_wup_id
,0 AS nb_id
, k.mandant_id
, k.kasse_nr
, k.kunde_fg
, k.bon_beginn
, k.bon_ende
, k.turnover_fg


,CASE WHEN user_wrg.wrg_typ_id = 0 THEN kurs.nach_wrg_id ELSE man.default_wrg END AS wrg_id
, k.kasse_typ_id
, r.bon_zeile
, r.kl_art_id
,a.art_id
, r.ean_kasse
, r.menge
, r.einh_id
, r.umsatz_brutto AS test
, CASE WHEN k.wrg_id <> 'EUR' AND man.default_wrg = 'EUR' 
    THEN r.umsatz_brutto * kurs.umrechnungskurs  
    WHEN user_wrg.wrg_typ_id=0 THEN r.umsatz_brutto*kurs.umrechnungskurs ELSE r.umsatz_brutto END AS umsatz_brutto
, m.mwst
, r.reklamationsgrund_id
, r.reklamationstyp_id
, r.menge_fg
, r.mhd
, r.los_charge
, r.kunden_text
, r.art_id_ref
, r.kpos_erfassung_id
FROM dbp_v_ods.v_ods_bon_kopf k

INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = k.mandant_id
   AND v05.wup_id = CASE WHEN TRY_CAST(k.wup_id  AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(k.wup_id  AS INTEGER) END
   AND v05.wup_id = k.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))


INNER JOIN dbp_v_ods.v_ods_bon_retoure r
ON  k.bon_id     = r.bon_id
AND k.wup_id     = r.wup_id
AND k.mandant_id = r.mandant_id


INNER JOIN dbp_view.v_mwst_per m
ON r.mandant_id = m.mandant_id
AND r.mwst_id = m.mwst_id
AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis 

INNER JOIN dbp_view.v_art a
ON r.kl_art_id = a.kl_art_id
AND r.mandant_id = a.mandant_id


JOIN dbp_view.v_mandant man
ON k.mandant_id = man.mandant_id

JOIN DBP_MSI_VIEW_SCM_MATERIALIZED.mv_kurs kurs
ON k.wrg_id = kurs.von_wrg_id

CROSS JOIN DBP_MSI_VIEW_SCM_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU user_wrg

WHERE (k.bon_id, k.wup_id, k.mandant_id) NOT IN
(
SELECT bon_id, wup_id, mandant_id
FROM dbp_v_ods.v_ods_bon_storno
);