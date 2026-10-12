create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_MA_KOSTENSTELLE_LOHNART_ZU_PER_1(
	MANDANT_ID,
	KRK_ID,
	KOSTENSTELLE_ID,
	MITARBEITER_ID,
	LOHNART_ID,
	KJMO,
	ANZAHL_LOHNART,
	ZEITART_ID,
	ABRECHNUNG_IN_PERIODE,
	ABRECHNUNG_FUER_PERIODE,
	ZAHLUNG_DAT,
	KOSTENSTELLE_VON_ID,
	KOSTENSTELLE_NACH_ID,
	ABRECHNUNGSTYP_FUER_PERIODE,
	ANZAHL_ZEITART,
	AUSTRITTSDATUM
) as





   SELECT
   v01.mandant_id, 
   v01.krk_id, 
   v01.kostenstelle_id, 
   v01.mitarbeiter_id, 
   v01.lohnart_id, 
   v01.kjmo, 
   CASE
    WHEN zeitart_id = '-1' AND lohnart_id IS NOT NULL 
    THEN v01.anzahl_lohnart  
   END AS anzahl_lohnart,
   v01.zeitart_id,
   v01.abrechnung_in_periode,
   v01.abrechnung_fuer_periode,
   v01.zahlung_dat,
   v01.kostenstelle_von_id,
   v01.kostenstelle_nach_id,
   v01.abrechnungstyp_fuer_periode,
   CASE 
    WHEN zeitart_id IS NOT NULL AND lohnart_id = '-1' 
    THEN v01.anzahl_lohnart  
   END AS anzahl_zeitart,
   COALESCE( v02.dat_von -1, CAST( '9999-12-31' AS DATE))  AS austrittsdatum
   FROM dbp_view.v_ma_kostenstelle_lohnart_zu_per_1 v01
	LEFT JOIN
	(SELECT v0.mandant_id
	,v0.mitarbeiter_id
	,v0.kjmo
	,MIN(v0.dat_von) AS dat_von
	FROM dbp_view.v_ma_hr_massnahme_zu_per_1  v0
	WHERE v0.hr_massnahme_id = '04'
	GROUP BY
	v0.mandant_id
	,v0.mitarbeiter_id
	,v0.kjmo)
	v02
	ON  v01.mitarbeiter_id = v02.mitarbeiter_id
	AND v01.mandant_id = v02.mandant_id
	AND v01.kjmo = v02.kjmo;