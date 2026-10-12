CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), wup_id
OPTIONS(description='Nummer des Warenumschlagsplatzes'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), kjmo
OPTIONS(description='Kalenderjahremonat, Format JJJJMM'), gj OPTIONS(description='Geschäftsjahr'), akt_gj
OPTIONS(description='Zähler auf Basis des aktuellen Geschäftsjahres'), akt_mo
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_2 darstellt. Der aktuelle Monat_2 hat den Wert 0, der vorige Monat_2 -1 und der nächste Monat_2 den Wert 1'),
mo_kj OPTIONS(description='Laufender Monat_2 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'),
ums_netto OPTIONS(description='Umsatz netto (K0-1) > lfd. Monat_2 aus Kasse'), ums_netto_kvj
OPTIONS(description='Umsatz netto (K0-1) Vorjahr'), ums_netto_kvvj
OPTIONS(description='Umsatz netto (K0-1) Vor-Vorjahr'), ums_netto_plan OPTIONS(description='Umsatz netto (K0-1 Plan'),
ums_netto_plan_extern OPTIONS(description='Umsatz netto Planwert extern'), anz_kunde
OPTIONS(description='Anzahl Kunden'), anz_kunde_kvj OPTIONS(description='Anzahl Kunden Kalendertag im Vorjahr'),
anz_kunde_kvvj OPTIONS(description='Anzahl Kunden Kalendertag im Vorvorjahr'), anz_offen
OPTIONS(description='Anzahl Öffnungstage'), anz_offen_kvj
OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vorjahr'), anz_offen_kvvj
OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vor-Vorjahr'), rohertrag OPTIONS(description='Rohertrag (K111)'),
rohertrag_kum OPTIONS(description='Rohertrag (K111) kum.'), rohertrag_kvj
OPTIONS(description='Rohertrag (K111) Vorjahr'), rohertrag_kvj_kum OPTIONS(description='Rohertrag (K111) Vorjahr kum.'),
rohertrag_plan OPTIONS(description='Rohertrag (K111) Plan'), rohertrag_plan_kum
OPTIONS(description='Rohertrag (K111) Plan kum.'), pers_kosten
OPTIONS(description='Personal Kosten Gesamt (K2) > Vormonat aus XLS'), pers_kosten_kum
OPTIONS(description='Personal Kosten Gesamt (K2) kum > Vormonat aus XLS'), pers_kosten_kvj
OPTIONS(description='Personal Kosten Gesamt (K2) Vorjahr'), pers_kosten_kvj_kum
OPTIONS(description='Personal Kosten Gesamt (K2) Vorjahr kum.'), pers_kosten_plan
OPTIONS(description='Personal Kosten Gesamt (K2) Plan'), pers_kosten_plan_kum
OPTIONS(description='Personal Kosten Gesamt (K2) Plan kum.'), pers_k_ohne
OPTIONS(description='Personalkosten_2 ohne Abgrenzung (K2-1) > Vormonat aus XLS'), pers_k_ohne_kum
OPTIONS(description='Personalkosten_2 ohne Abgrenzung (K2-1)  kum > Vormonat aus XLS'), pers_k_ohne_kvj
OPTIONS(description='Personalkosten_2 ohne Abgrenzung (K2-1) Vorjahr'), pers_k_ohne_kvj_kum
OPTIONS(description='Personalkosten_2 ohne Abgrenzung (K2-1) Vorjahr kum.'), pers_k_ohne_plan
OPTIONS(description='Personalkosten_2 ohne Abgrenzung (K2-1) Plan'), pers_k_ohne_plan_kum
OPTIONS(description='Personalkosten_2 ohne Abgrenzung (K2-1) Plan kum.'), pers_std OPTIONS(description='Personal Stunden_2'),
pers_std_kum OPTIONS(description='Personal Stunden_2'), pers_std_kvj OPTIONS(description='Personal Stunden_2'),
pers_std_kvj_kum OPTIONS(description='Personal Stunden_2'), pers_std_plan OPTIONS(description='Personal Stunden_2'),
pers_std_plan_kum OPTIONS(description='Personal Stunden_2'), pers_auq OPTIONS(description='AU-Quote (Arbeitsunfähigkeit)'),
pers_auq_kum OPTIONS(description='AU-Quote (Arbeitsunfähigkeit)'), pers_auq_kvj
OPTIONS(description='AU-Quote (Arbeitsunfähigkeit)'), pers_auq_kvj_kum
OPTIONS(description='AU-Quote (Arbeitsunfähigkeit)'), pers_fluq OPTIONS(description='Fluktuations-Quote'), pers_fluq_kum
OPTIONS(description='Fluktuations-Quote'), pers_fluq_kvj OPTIONS(description='Fluktuations-Quote'), pers_fluq_kvj_kum
OPTIONS(description='Fluktuations-Quote')) AS SELECT mandant_id,
 nb_id,
 wup_id,
 wrg_id,
 kjmo,
 gj,
 akt_gj,
 akt_mo,
 mo_kj,
 ums_netto,
 ums_netto_kvj,
 ums_netto_kvvj,
 ums_netto_plan,
 ums_netto_plan_extern,
 anz_kunde,
 anz_kunde_kvj,
 anz_kunde_kvvj,
 anz_offen,
 anz_offen_kvj,
 anz_offen_kvvj,
 rohertrag,
 rohertrag_kum,
 rohertrag_kvj,
 rohertrag_kvj_kum,
 rohertrag_plan,
 rohertrag_plan_kum,
 pers_kosten,
 pers_kosten_kum,
 pers_kosten_kvj,
 pers_kosten_kvj_kum,
 pers_kosten_plan,
 pers_kosten_plan_kum,
 pers_k_ohne,
 pers_k_ohne_kum,
 pers_k_ohne_kvj,
 pers_k_ohne_kvj_kum,
 pers_k_ohne_plan,
 pers_k_ohne_plan_kum,
 pers_std,
 pers_std_kum,
 pers_std_kvj,
 pers_std_kvj_kum,
 pers_std_plan,
 pers_std_plan_kum,
 pers_auq,
 pers_auq_kum,
 pers_auq_kvj,
 pers_auq_kvj_kum,
 pers_fluq,
 pers_fluq_kum,
 pers_fluq_kvj,
 pers_fluq_kvj_kum
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2;