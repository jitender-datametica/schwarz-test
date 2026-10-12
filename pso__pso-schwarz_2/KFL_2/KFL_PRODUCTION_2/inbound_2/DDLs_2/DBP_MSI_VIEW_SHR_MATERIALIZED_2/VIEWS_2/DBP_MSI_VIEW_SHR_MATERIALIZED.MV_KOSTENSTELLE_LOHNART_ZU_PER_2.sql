create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_KOSTENSTELLE_LOHNART_ZU_PER_2(
	MANDANT_ID,
	KRK_ID,
	KOSTENSTELLE_ID,
	LOHNART_ID,
	KJMO,
	ANZAHL_LOHNART,
	WRG_ID,
	BETRAG_LOHNART,
	ZEITART_ID,
	ABRECHNUNG_IN_PERIODE,
	ABRECHNUNG_FUER_PERIODE,
	ZAHLUNG_DAT,
	KOSTENSTELLE_VON_ID,
	KOSTENSTELLE_NACH_ID,
	ABRECHNUNGSTYP_FUER_PERIODE,
	ANZAHL_ZEITART
) as






  SELECT
  v01.mandant_id,
  v01.krk_id,
  v01.kostenstelle_id,
  v01.lohnart_id,
  v01.kjmo,
  CASE
   WHEN zeitart_id = '-1' AND lohnart_id IS NOT NULL
   THEN v01.anzahl_lohnart
  END AS anzahl_lohnart,
  v400.wrg_id,
  CASE
   WHEN zeitart_id = '-1' AND lohnart_id IS NOT NULL AND v100.wrg_typ_id = 1
   THEN v01.betrag_lohnart
   WHEN zeitart_id = '-1' AND lohnart_id IS NOT NULL AND v100.wrg_typ_id = 0
   THEN v01.betrag_lohnart * v300.umrechnungskurs
  END AS betrag_lohnart,
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
  END AS anzahl_zeitart
 FROM dbp_view.v_kostenstelle_lohnart_zu_per_2 v01

 
 CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v100

 
 CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v200

 
 JOIN dbp_view.v_kurs_2 v300
  ON v01.wrg_id = v300.von_wrg_id
  AND CURRENT_DATE BETWEEN v300.dat_von AND v300.dat_bis
  AND v200.kurstyp_id = v300.kurstyp_id
  AND v300.nach_wrg_id = 'EUR'

 
 JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
  ON v01.mandant_id = v400.mandant_id
  AND v100.wrg_typ_id = v400.wrg_typ_id;