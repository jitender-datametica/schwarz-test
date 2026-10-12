create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR_MATERIALIZED.MV_KOSTENSTELLE_LOHNART_ZU_PER_1(
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
-- Erstellt von HMue2308 am 06.09.2017
-- AP0019874, SPEC0025176
-- Umgeändert von HMue2308 am 21.09.2017 - Feld: Stunden_Lohnart in Anzahl_Lohnart umgeändert
-- 21.11.2022, AP0025890, SPEC0072496, Erweiterung von neuen Spalten 
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
  v01.wrg_id, 
  CASE 
   WHEN zeitart_id = '-1' AND lohnart_id IS NOT NULL 
   THEN v01.betrag_lohnart  
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
 FROM dbp_view.v_kostenstelle_lohnart_zu_per_1 v01;