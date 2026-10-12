CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_plz_besch_region_zu_per (mandant_id
OPTIONS(description='Mandant im DWH.'), gp_id OPTIONS(description='Lieferant.'), land_id
OPTIONS(description='Land ID aus belos_adresse.'), abholung_plz
OPTIONS(description='Postleitzahl (muss nicht = gp_plz sein, bzw. sind mehrere pro GP möglich).'), dat_von
OPTIONS(description='Gültigkeitsdatum von.'), dat_bis OPTIONS(description='Gültigkeitsdatum bis.'), besch_region_id
OPTIONS(description='Beschaffungsregion SCM.'), besch_region_koordination_id
OPTIONS(description='Beschaffungsregion SCM, welche die Koordination des Lieferanten übernimmt. Kann von besch_region_id abweichen.'),
anz_pal_stapelfaktor
OPTIONS(description='Durchschnittliche Stapelfaktor (Anzahl Paletten übereinander) für den jeweiligen GP (Lieferanten) und das zugehörige Gültigkeitsintervall. Dieser Wert ist eine relevante Größe für die Abrechnung, insbesondere hinsichtlich der LKW-Auslastung. Der Wert dürfte in der Regel zwischen 1 und 5 liegen.'))
OPTIONS(DESCRIPTION = `LOG - THIS TABLE CONTAINS RELATIONS BETWEEN SUPPLIER (GP_ID), ZIPCODE OF THE PICKUP DESTINATION (ABHOLUNG_PLZ) AND PROCUREMENT REGION (BESCHAFFUNGSREGION, BESCH_REGION_ID AND BESCH_REGION_KOORDINATION_ID). A SUPPLIER CAN HAVE SEVERAL ADDRESSES WHERE GOODS ARE PRODUCED AND PICKED UP BY TRANSPORTERS, WHICH CAN THEREFORE HAVE DIFFERENT ZIP CODES FROM THE GP_PLZ OF THE MAIN GP OFFICE. A BESCHAFFUNGSREGION IS A PROCUREMENT REGION; BESCH_REGION_ID IS THE ONE WHERE THE PROCUREMENT HAPPENS, WHILE BESCH_REGION_KOORDINATION_ID CAN BE A DIFFERENT ONE BECAUSE THE COORDINATING OFFICE REGION CAN BE DIFFERENT FROM THE PICKUP REGION. BOTH OF THEM REFER TO BESCH_REGION_ID IN TS_L_BESCHAFFUNGSREGION. FILLED THROUGH SHAREPOINT-UPLOAD.`)
AS SELECT mandant_id,
 gp_id,
 land_id,
 abholung_plz,
 dat_von,
 dat_bis,
 besch_region_id,
 besch_region_koordination_id,
 anz_pal_stapelfaktor
FROM kfl_production_dbp_data.gp_plz_besch_region_zu_per;