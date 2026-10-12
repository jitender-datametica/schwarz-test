CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_plz_besch_region_zu_per_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), gp_id OPTIONS(description='Lieferant.'), land_id
OPTIONS(description='Land_2 ID aus belos_adresse.'), abholung_plz
OPTIONS(description='Postleitzahl (muss nicht = gp_plz sein, bzw. sind mehrere pro GP_2 möglich).'), dat_von
OPTIONS(description='Gültigkeitsdatum von.'), dat_bis OPTIONS(description='Gültigkeitsdatum bis.'), besch_region_id
OPTIONS(description='Beschaffungsregion SCM.'), besch_region_koordination_id
OPTIONS(description='Beschaffungsregion SCM, welche die Koordination des Lieferanten übernimmt. Kann von besch_region_id abweichen.'),
anz_pal_stapelfaktor
OPTIONS(description='Durchschnittliche Stapelfaktor (Anzahl Paletten übereinander) für den jeweiligen GP_2 (Lieferanten) und das zugehörige Gültigkeitsintervall. Dieser Wert ist eine_2 relevante Größe für die Abrechnung, insbesondere hinsichtlich der LKW-Auslastung. Der Wert dürfte in der Regel zwischen 1 und 5 liegen.'))
AS SELECT mandant_id,
 gp_id,
 land_id,
 abholung_plz,
 dat_von,
 dat_bis,
 besch_region_id,
 besch_region_koordination_id,
 anz_pal_stapelfaktor
FROM kfl_production_dbp_data.gp_plz_besch_region_zu_per_2;