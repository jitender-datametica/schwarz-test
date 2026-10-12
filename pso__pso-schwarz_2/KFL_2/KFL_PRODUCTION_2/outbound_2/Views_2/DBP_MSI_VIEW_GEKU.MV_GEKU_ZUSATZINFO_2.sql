CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_zusatzinfo_2 (geku_ticket_id, artikelbez, artikelinfo,
preis_wettbewerber, preis_kaufland, name_wettbewerber, standort_wettbewerber, datum_einkauf, datum_handzettel,
artikelbez_kaufland, kaufland_nr, artikelbez_uebers, qualimangel, charge, datum_schadensfall, ean_2, flw_bestellung_id,
flw_etikett_id, flw_frische_id, flw_gewicht_id, flw_herkunft_id, flw_preis_id, flw_qualitaet_id, flw_sonstiges_id,
flw_sortiment_id, flw_verpackung_id, flw_warenpraesenz_id, flw_zuschnitt_id, fremdkoerper, fremdkoerper_uebers,
herstellerinfo, kaufdatum, kaufpreis, marktbestand, mhd, produktionsdatum, status_fremdkoerper_id, vico_id,
vico_nickname, vico_plattform, vico_treffergrund, vico_url, kundenalter, datum_angewendet, datum_aufgetreten, symptome,
fuellmenge, artikelgruppe_og_id, geschlecht_id, produktfrage_id, beschwerdebuch, hersteller_id, hersteller_food_id,
hersteller_purland_id, hersteller_food_fleisch_id, schaedlingsart_id, zauberwort_id) AS SELECT V01.geku_ticket_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '01_Artikelbezeichnung'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS artikelbez,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '02_Artikelinformation'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS artikelinfo,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '03_Preisangaben_Wettbewerber'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS preis_wettbewerber,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '04_Preisangaben_Kaufland'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS preis_kaufland,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '05_Name_Wettbewerber'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS name_wettbewerber,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '06_Standort_Wettbewerber'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS standort_wettbewerber,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '07_Datum_Einkauf'
   THEN V02.zusatzinfo_date
   ELSE NULL
   END) AS datum_einkauf,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '08_Datum_Handzettel'
   THEN V02.zusatzinfo_date
   ELSE NULL
   END) AS datum_handzettel,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '09_Artikelbezeichnung_Kaufland'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS artikelbez_kaufland,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = '10_Kaufland_Nummer'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS kaufland_nr,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Artikelbezeichnung - übersetzt'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS artikelbez_uebers,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Beeinträchtigung durch sonstigen Qualitätsmangel'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS qualimangel,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Charge / Losnummer'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS charge,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Datum Schadensfall'
   THEN V02.zusatzinfo_date
   ELSE NULL
   END) AS datum_schadensfall,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'EAN_2'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS ean_2,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Bestellung (Fleisch)'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_bestellung_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Etikettangaben'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_etikett_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Frische'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_frische_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Gewichtsverlust /-abweichungen'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_gewicht_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Herkunft'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_herkunft_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Preis'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_preis_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Qualität'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_qualitaet_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Sonstiges'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_sonstiges_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Sortiment / Listung'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_sortiment_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Verpackung'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_verpackung_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Warenpräsenz'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_warenpraesenz_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'FLW Zuschnitt (Fleisch)'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS flw_zuschnitt_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Fremdkörper'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS fremdkoerper,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Fremdkörper - übersetzt'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS fremdkoerper_uebers,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Herstellerinformation / LFN'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS herstellerinfo,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Kaufdatum'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS kaufdatum,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Kaufpreis'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS kaufpreis,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Marktbestand SAP'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS marktbestand,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'MHD'
   THEN V02.zusatzinfo_date
   ELSE NULL
   END) AS mhd,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Produktionsdatum'
   THEN V02.zusatzinfo_date
   ELSE NULL
   END) AS produktionsdatum,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Status_2 Fremdkörper'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS status_fremdkoerper_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'VICO ID'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS vico_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'VICO Nickname'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS vico_nickname,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'VICO Plattform'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS vico_plattform,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'VICO Treffergrund'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS vico_treffergrund,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'VICO URL'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS vico_url,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Alter'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS kundenalter,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Angewendet wann'
   THEN V02.zusatzinfo_date
   ELSE NULL
   END) AS datum_angewendet,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Aufgetreten wann'
   THEN V02.zusatzinfo_date
   ELSE NULL
   END) AS datum_aufgetreten,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Beschreibung der Symptome'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS symptome,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Füllmenge'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS fuellmenge,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Artikelgruppen O&G'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS artikelgruppe_og_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Geschlecht'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS geschlecht_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Liegt das Produkt vor?'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS produktfrage_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Beschwerdebuch Nummer'
   THEN CAST(V02.zusatzinfo_text AS STRING)
   ELSE NULL
   END) AS beschwerdebuch,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Hersteller Non-Food'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS hersteller_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Hersteller Food'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS hersteller_food_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Hersteller Fleischwaren/Handelswaren'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS hersteller_purland_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Hersteller Food/Fleischwaren'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS hersteller_food_fleisch_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Schädlingsart'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS schaedlingsart_id,
 MAX(CASE
   WHEN V03.zusatzinfo_bez = 'Zauberwort'
   THEN V02.zusatzinfo_sel_id
   ELSE - 1
   END) AS zauberwort_id
FROM kfl_production_dbp_view.v_geku_ticket_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_geku_ticket_zusatzinfo_zu_2 AS V02 ON V01.geku_ticket_id = V02.geku_ticket_id
 LEFT JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS V03 ON V02.zusatzinfo_id = V03.zusatzinfo_id AND V03.spr_id
    = 22
GROUP BY V01.geku_ticket_id;