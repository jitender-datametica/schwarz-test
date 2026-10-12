--==============================================================
-- Table: tupel_52_wochen_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tupel_52_wochen_2
   generated from Powerdesigner on Mittwoch, 11. Januar 2023 14:33:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.tupel_52_wochen_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
kjwo_52 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Format JJJJWW, letzte Kalenderwoche des 52 Wochen-Zeitraums.'),
matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden.'),
anzahl_markt_wochen_kombis_abverkauf_af BIGNUMERIC(38,0)
OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf aktionsfrei.'),
anzahl_markt_wochen_kombis_abverkauf_sa BIGNUMERIC(38,0)
OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sonderaktion.'),
anzahl_markt_wochen_kombis_abverkauf_af_vj BIGNUMERIC(38,0)
OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf aktionsfrei des entsprechenden Vorjahreszeitraums.'),
anzahl_markt_wochen_kombis_abverkauf_sa_vj BIGNUMERIC(38,0)
OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sonderaktion des entsprechenden Vorjahreszeitraums.'),
kassenumsatz_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz inkl. Umsatzsteuer.'),
kassenumsatz_af_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz aktionsfrei inkl. Umsatzsteuer.'),
kassenumsatz_sa_kl_absolut_brutto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Sonderaktion inkl. Umsatzsteuer.'),
kassenumsatz_kl_absolut_brutto_vj NUMERIC(18,4)
OPTIONS(description='Kassenumsatz inkl. Umsatzsteuer des entsprechenden Vorjahreszeitraums.'),
kassenumsatz_af_kl_absolut_brutto_vj NUMERIC(18,4)
OPTIONS(description='Kassenumsatz aktionsfrei inkl. Umsatzsteuer des entsprechenden Vorjahreszeitraums.'),
kassenumsatz_sa_kl_absolut_brutto_vj NUMERIC(18,4)
OPTIONS(description='Kassenumsatz Sonderaktion inkl. Umsatzsteuer des entsprechenden Vorjahreszeitraums.'),
kassenumsatz_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz netto.'),
kassenumsatz_af_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz aktionsfrei netto.'),
kassenumsatz_sa_kl_absolut_netto NUMERIC(18,4) OPTIONS(description='Kassenumsatz Sonderaktion netto.'),
kassenumsatz_kl_absolut_netto_vj NUMERIC(18,4)
OPTIONS(description='Kassenumsatz netto des entsprechenden Vorjahreszeitraums.'),
kassenumsatz_af_kl_absolut_netto_vj NUMERIC(18,4)
OPTIONS(description='Kassenumsatz aktionsfrei netto des entsprechenden Vorjahreszeitraums.'),
kassenumsatz_sa_kl_absolut_netto_vj NUMERIC(18,4)
OPTIONS(description='Kassenumsatz Sonderaktion netto des entsprechenden Vorjahreszeitraums.'),
absatz_kl NUMERIC(18,4) OPTIONS(description='Absatz.'),
absatz_af_kl NUMERIC(18,4) OPTIONS(description='Absatz aktionsfrei.'),
absatz_sa_kl NUMERIC(18,4) OPTIONS(description='Absatz Sonderaktion.'),
absatz_kl_vj NUMERIC(18,4) OPTIONS(description='Absatz des entsprechenden Vorjahreszeitraums.'),
absatz_af_kl_vj NUMERIC(18,4) OPTIONS(description='Absatz aktionsfrei des entsprechenden Vorjahreszeitraums.'),
absatz_sa_kl_vj NUMERIC(18,4) OPTIONS(description='Absatz Sonderaktion des entsprechenden Vorjahreszeitraums.'),
absatz_sst1 NUMERIC(18,4) OPTIONS(description='Absatz Sortimentsstufe 1.'),
absatz_sst2 NUMERIC(18,4) OPTIONS(description='Absatz Sortimentsstufe 2.'),
absatz_sst3 NUMERIC(18,4) OPTIONS(description='Absatz Sortimentsstufe 3.'),
absatz_sst4 NUMERIC(18,4) OPTIONS(description='Absatz Sortimentsstufe 4.'),
absatz_sst5 NUMERIC(18,4) OPTIONS(description='Absatz Sortimentsstufe 5.'),
absatz_sst6 NUMERIC(18,4) OPTIONS(description='Absatz Sortimentsstufe 6.'),
absatz_sst7 NUMERIC(18,4) OPTIONS(description='Absatz Sortimentsstufe 7.'),
absatz_ksst1 NUMERIC(18,4) OPTIONS(description='Absatz K-Sortimentstufe 1 (KMO).'),
absatz_ksst2 NUMERIC(18,4) OPTIONS(description='Absatz K-Sortimentstufe 2 (KMO).'),
absatz_ksst3 NUMERIC(18,4) OPTIONS(description='Absatz K-Sortimentstufe 3 (KMO).'),
absatz_ksst4 NUMERIC(18,4) OPTIONS(description='Absatz K-Sortimentstufe 4 (KMO).'),
absatz_ksst5 NUMERIC(18,4) OPTIONS(description='Absatz K-Sortimentstufe 5 (KMO).'),
absatz_ksst6 NUMERIC(18,4) OPTIONS(description='Absatz K-Sortimentstufe 6 (KMO).'),
absatz_ksst7 NUMERIC(18,4) OPTIONS(description='Absatz K-Sortimentstufe 7 (KMO).'),
absatz_ost_basis NUMERIC(18,4) OPTIONS(description='Absatz Ost Basis (DE).'),
absatz_ost_gross NUMERIC(18,4) OPTIONS(description='Absatz Ost groß (DE).'),
absatz_sued_ost NUMERIC(18,4) OPTIONS(description='Absatz Süd-Ost (DE).'),
absatz_sued_west NUMERIC(18,4) OPTIONS(description='Absatz Süd-West (DE).'),
absatz_west NUMERIC(18,4) OPTIONS(description='Absatz West (DE).'),
absatz_nord NUMERIC(18,4) OPTIONS(description='Absatz Nord (DE).'),
markt_wochen_sst1 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sortimentsstufe 1.'),
markt_wochen_sst2 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sortimentsstufe 2.'),
markt_wochen_sst3 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sortimentsstufe 3.'),
markt_wochen_sst4 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sortimentsstufe 4.'),
markt_wochen_sst5 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sortimentsstufe 5.'),
markt_wochen_sst6 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sortimentsstufe 6.'),
markt_wochen_sst7 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf Sortimentsstufe 7.'),
markt_wochen_ksst1 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf K-Sortimentsstufe 1 (KMO).'),
markt_wochen_ksst2 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf K-Sortimentsstufe 2 (KMO).'),
markt_wochen_ksst3 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf K-Sortimentsstufe 3 (KMO).'),
markt_wochen_ksst4 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf K-Sortimentsstufe 4 (KMO).'),
markt_wochen_ksst5 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf K-Sortimentsstufe 5 (KMO).'),
markt_wochen_ksst6 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf K-Sortimentsstufe 6 (KMO).'),
markt_wochen_ksst7 BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf K-Sortimentsstufe 7 (KMO).'),
markt_wochen_ost_basis BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis Ost Basis (DE).'),
markt_wochen_ost_gross BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis Ost groß (DE).'),
markt_wochen_sued_ost BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis Süd-Ost (DE).'),
markt_wochen_sued_west BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis Süd-West Basis (DE).'),
markt_wochen_west BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis West Basis (DE).'),
markt_wochen_nord BIGNUMERIC(38,0) OPTIONS(description='Markt-Wochen-Kombis Nord Basis (DE).'),
anzahl_markt_wochen_kombis_abverkauf_mit_listung BIGNUMERIC(38,0)
OPTIONS(description='Markt-Wochen-Kombis mit Abverkauf und Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag).'),
anzahl_markt_wochen_kombis_listung BIGNUMERIC(38,0)
OPTIONS(description='Markt-Wochen-Kombis mit Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag).'),
rohertrag_ekmep_olk_4n NUMERIC(18,4) OPTIONS(description='Rohertrag, für DE EKMEP ohne Logistikkosten, für KMO 4netto.'),
rohertrag_ekmep_olk_4n_vj NUMERIC(18,4)
OPTIONS(description='Rohertrag Vorjahr, für DE EKMEP ohne Logistikkosten, für KMO 4netto.'),
rohertrag_ekmep_olk_4n_af NUMERIC(18,4)
OPTIONS(description='Rohertrag aktionsfrei, für DE EKMEP ohne Logistikkosten, für KMO 4netto.'),
rohertrag_ekmep_olk_4n_sa NUMERIC(18,4)
OPTIONS(description='Rohertrag Sonderaktion, für DE EKMEP ohne Logistikkosten, für KMO 4netto.'),
rohertrag_ekmep_olk_4n_af_vj NUMERIC(18,4)
OPTIONS(description='Rohertrag aktionsfrei Vorjahr, für DE EKMEP ohne Logistikkosten, für KMO 4netto.'),
rohertrag_ekmep_olk_4n_sa_vj NUMERIC(18,4)
OPTIONS(description='Rohertrag Sonderaktion Vorjahr, für DE EKMEP ohne Logistikkosten, für KMO 4netto.'),
totalabschriften_wert_netto_absolut NUMERIC(18,4)
OPTIONS(description='Alle Abschriften_2 / Preisänderungen (nicht nur "Total" wie der Name suggeriert, war fachlich nicht sauber abgrenzbar).'),
preisabschriften_preisanderungen_wert_netto_absolut NUMERIC(18,4)
OPTIONS(description='Abschriften_2 VK_2 netto, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_vj NUMERIC(18,4)
OPTIONS(description='Alle Abschriften_2 / Preisänderungen (nicht nur "Total" wie der Name suggeriert, war fachlich nicht sauber abgrenzbar), Vorjahr.'),
preisabschriften_preisanderungen_wert_netto_absolut_vj NUMERIC(18,4)
OPTIONS(description='Abschriften_2 VK_2 netto VJ, nur Preisabschriften/Preisänderungen (Definition offen). Kann potenziell aus der Tabelle entfernt werden.'),
totalabschriften_wert_netto_absolut_wg NUMERIC(18,4)
OPTIONS(description='Alle Abschriften_2 / Preisänderungen (nicht nur "Total" wie der Name suggeriert, war fachlich nicht sauber abgrenzbar) der WG in Summe.'),
preisabschriften_preisanderungen_wert_netto_absolut_wg NUMERIC(18,4)
OPTIONS(description='Abschriften_2 VK_2 netto, nur Preisabschriften/Preisänderungen (Definition offen), Gesamtsumme der WG. Kann potenziell aus der Tabelle entfernt werden.'),
kassenumsatz_kl_absolut_netto_wg NUMERIC(18,4) OPTIONS(description='Kassenumsatz netto der Warengruppe in Summe.'),
absatz_af_kl_listungswochen NUMERIC(18,4)
OPTIONS(description='Absatz aktionsfrei von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag).'),
absatz_af_kl_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Absatz aktionsfrei von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag), Vorjahr.'),
absatz_sa_kl_listungswochen NUMERIC(18,4)
OPTIONS(description='Absatz Sonderaktion von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag).'),
absatz_sa_kl_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Absatz Sonderaktion von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag), Vorjahr.'),
kassenumsatz_af_kl_absolut_netto_listungswochen NUMERIC(18,4)
OPTIONS(description='Kassenumsatz netto aktionsfrei von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag).'),
kassenumsatz_af_kl_absolut_netto_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Kassenumsatz netto aktionsfrei von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag), Vorjahr.'),
kassenumsatz_sa_kl_absolut_netto_listungswochen NUMERIC(18,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag).'),
kassenumsatz_sa_kl_absolut_netto_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Kassenumsatz netto Sonderaktion von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag), Vorjahr.'),
rohertrag_ekmep_olk_4n_af_listungswochen NUMERIC(18,4)
OPTIONS(description='Rohertrag aktionsfrei, für DE EKMEP ohne Logistikkosten, für KMO 4netto, von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag).'),
rohertrag_ekmep_olk_4n_af_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Rohertrag aktionsfrei, für DE EKMEP ohne Logistikkosten, für KMO 4netto, von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag), Vorjahr.'),
rohertrag_ekmep_olk_4n_sa_listungswochen NUMERIC(18,4)
OPTIONS(description='Rohertrag Sonderaktion, für DE EKMEP ohne Logistikkosten, für KMO 4netto, von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag).'),
rohertrag_ekmep_olk_4n_sa_vj_listungswochen NUMERIC(18,4)
OPTIONS(description='Rohertrag Sonderaktion, für DE EKMEP ohne Logistikkosten, für KMO 4netto, von Wochen mit aktiver Listung (Stichtag Listung für eine_2 Woche_2 immer Stand Samstag). Vorjahr.'),
kjwo_update BIGNUMERIC(38,0) OPTIONS(description='Kalenderjahreswoche. Format JJJJWW.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjwo_52, matching_id) NOT ENFORCED
) OPTIONS(description='EK_SORT - Sales_2 data for Kaufland articles aggregated over 52 weeks (full year).');