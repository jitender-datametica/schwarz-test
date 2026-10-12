--==============================================================
-- Table: vis_monat_ums_kunde_pers_wup_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_monat_ums_kunde_pers_wup_1
   generated from Powerdesigner on Freitag, 16. Mai 2025 16:13:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr'),
akt_gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Geschäftsjahres'),
akt_mo BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_1 darstellt. Der aktuelle Monat_1 hat den Wert 0, der vorige Monat_1 -1 und der nächste Monat_1 den Wert 1'),
mo_kj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufender Monat_1 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'),
ums_netto BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto (K0-1) > lfd. Monat_1 aus Kasse'),
ums_netto_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto (K0-1) Vorjahr'),
ums_netto_kvvj BIGNUMERIC(38,2) OPTIONS(description='Umsatz netto (K0-1) Vor-Vorjahr'),
ums_netto_plan BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto (K0-1 Plan'),
ums_netto_plan_extern BIGNUMERIC(38,2) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz netto Planwert extern'),
anz_kunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Kunden'),
anz_kunde_kvj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Kunden Kalendertag im Vorjahr'),
anz_kunde_kvvj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Kunden Kalendertag im Vorvorjahr'),
anz_offen BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Öffnungstage'),
anz_offen_kvj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vorjahr'),
anz_offen_kvvj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vor-Vorjahr'),
rohertrag BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Rohertrag (K111)'),
rohertrag_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Rohertrag (K111) kum.'),
rohertrag_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Rohertrag (K111) Vorjahr'),
rohertrag_kvj_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Rohertrag (K111) Vorjahr kum.'),
rohertrag_plan BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Rohertrag (K111) Plan'),
rohertrag_plan_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Rohertrag (K111) Plan kum.'),
pers_kosten BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Kosten Gesamt (K2) > Vormonat aus XLS'),
pers_kosten_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Kosten Gesamt (K2) kum > Vormonat aus XLS'),
pers_kosten_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Kosten Gesamt (K2) Vorjahr'),
pers_kosten_kvj_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Kosten Gesamt (K2) Vorjahr kum.'),
pers_kosten_plan BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Kosten Gesamt (K2) Plan'),
pers_kosten_plan_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Kosten Gesamt (K2) Plan kum.'),
pers_k_ohne BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personalkosten_1 ohne Abgrenzung (K2-1) > Vormonat aus XLS'),
pers_k_ohne_kum BIGNUMERIC(38,2) NOT NULL
OPTIONS(description='Personalkosten_1 ohne Abgrenzung (K2-1)  kum > Vormonat aus XLS'),
pers_k_ohne_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personalkosten_1 ohne Abgrenzung (K2-1) Vorjahr'),
pers_k_ohne_kvj_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personalkosten_1 ohne Abgrenzung (K2-1) Vorjahr kum.'),
pers_k_ohne_plan BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personalkosten_1 ohne Abgrenzung (K2-1) Plan'),
pers_k_ohne_plan_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personalkosten_1 ohne Abgrenzung (K2-1) Plan kum.'),
pers_std BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Stunden_1'),
pers_std_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Stunden_1'),
pers_std_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Stunden_1'),
pers_std_kvj_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Stunden_1'),
pers_std_plan BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Stunden_1'),
pers_std_plan_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Personal Stunden_1'),
pers_auq BIGNUMERIC(38,2) NOT NULL OPTIONS(description='AU-Quote (Arbeitsunfähigkeit)'),
pers_auq_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='AU-Quote (Arbeitsunfähigkeit)'),
pers_auq_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='AU-Quote (Arbeitsunfähigkeit)'),
pers_auq_kvj_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='AU-Quote (Arbeitsunfähigkeit)'),
pers_fluq BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Fluktuations-Quote'),
pers_fluq_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Fluktuations-Quote'),
pers_fluq_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Fluktuations-Quote'),
pers_fluq_kvj_kum BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Fluktuations-Quote'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nb_id, wup_id, kjmo) NOT ENFORCED
) OPTIONS(description='VIS - Aggregat auf Monatsebene - MULTISET - Beladung aus wup_plan_tag_1');