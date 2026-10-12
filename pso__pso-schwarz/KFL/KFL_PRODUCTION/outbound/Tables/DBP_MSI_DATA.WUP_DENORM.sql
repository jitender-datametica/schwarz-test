--==============================================================
-- Table: wup_denorm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_denorm
   generated from Powerdesigner on Montag, 26. Februar 2024 17:47:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.wup_denorm (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer aus t001w.werks'),
bed_fleisch_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienkonzept Fleisch Flag'),
bed_fleisch_dat DATE OPTIONS(description='Datum, ab dem das aktuelle Bedienkonzept gültig ist'),
bed_wurst_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienkonzept Wurst Flag'),
bed_wurst_dat DATE OPTIONS(description='Bedienkonzept Wurst Datum'),
bed_gefl_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienkonzept Geflügel Flag'),
bed_gefl_dat DATE OPTIONS(description='Bedienkonzept Geflügel Datum'),
bed_kaese_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienkonzept  Käse Flag'),
bed_kaese_dat DATE OPTIONS(description='Bedienkonzept  Käse Datum'),
bed_fisch_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bedienkonzept Fisch. ID verweist auf SB, Bedienung oder Bedienung/SB'),
bed_fisch_dat DATE OPTIONS(description='Bedienkonzept Fisch Datum'),
bed_feink_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienkonzept Feinkost Flag'),
bed_feink_dat DATE OPTIONS(description='Bedienkonzept Feinkost Datum'),
bed_bulk_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienkonzept  Bulkfood Flag'),
bed_bulk_dat DATE OPTIONS(description='Bedienkonzept  Bulkfood Datum'),
bed_bedins_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienkonzept Bedieninsel Flag'),
bed_bedins_dat DATE OPTIONS(description='Bedienkonzept Bedieninsel Datum'),
bed_imbiss_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienkonzept Imbiss Flag'),
bed_imbiss_dat DATE OPTIONS(description='Bedienkonzept Imbiss Datum'),
bed_backshop_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bedienungskonzept Backshop Flag'),
bed_backshop_dat DATE OPTIONS(description='Bedienungskonzept Backshop Datum'),
backshop_system STRING(40) COLLATE 'und:ci' OPTIONS(description='Backshop System, z.Bsp. Discount'),
leergut_system STRING(40) COLLATE 'und:ci' OPTIONS(description='Leergut System, z.Bsp. Leergutautomat'),
anz_leergutautomaten BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der Leergutautomaten'),
glv_land_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID des GLV Land'),
stv_glv_land_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID des stellvertretenden GLV Land'),
gl_vertrieb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter_id der/des GL Vertrieb'),
gf_gbl_vertrieb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID der/des GF/GBL Vertrieb'),
vkl_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mitarbeiter ID der/des Verkaufsleiters. Achtung: abweichend von der bisher im DWH generierten VKL-ID'),
hausleiter_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID des Hausleiters'),
wbl_food_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Food'),
wbl_frische_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter Id der Warenbereichsleitung Frische'),
wbl_nonfood_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Nonfood'),
wbl_kasse_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Kasse'),
frische_manager_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID des Frischemanagements'),
regionale_psb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitarbeiter ID der regionalen Personalsachbearbeitung'),
tankstelle_vorh_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag ist gesetzt, wenn eine Tankstelle vorhanden ist. Kommt aus techn_platz_ebene_2'),
tankstelle_eigen_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag, ob eine Tankstelle in Eigenverwendung. 1 = eigen'),
ma_vermietung_id BIGNUMERIC(38,0) OPTIONS(description='Mitarbeiter Vermietung. Referenz zur Tabelle l_ma.'),
eigentum_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Eigentum Flag. Wenn = 1, dann Eigentum, 0 = Miete'),
dat_letzte_reorga DATE
OPTIONS(description='Datum der letzten großen Umbaumaßnahme. Wird aus cpr_cl_punkt_termin ermittelt.'),
parkhaus_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Parkhaus Kennzeichen. Kann die Werte 0= kein Parkhaus, 1 = Parkhaus, -1 = unbekannt annehmen. Die Information wird aus der Spalte betreiberart_bez der Tabelle l_ginfo_betreiberart ermittelt'),
getraenkemarkt_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen für einen separaten Getränkemarkt. Kann die Werte 0= kein Getränkemarkt. 1 = Getränkemarkt. -1 = unbekannt annehmen. Die Information wird aus der Spalte betreiberart_bez der Tabelle l_ginfo_betreiberart ermittelt'),
anz_aufzuege BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Aufzüge (gesamt) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
anz_rollsteige BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Rollsteige (gesamt) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
anz_aufzuege_intern BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Aufzüge (nur innerhalb der Verkaufsfläche) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
anz_rollsteige_intern BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Anzahl Rollsteige (nur innerhalb der Verkaufsfläche) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
untervermietung_kz STRING(20) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
untervermietung_text STRING(160) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
untervermietung_freitext STRING(160) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
hausleiter_sperr_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den Hausleiter gesperrt sind (1 = gesperrt)'),
vkl_sperr_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den VKL gesperrt sind (1 = gesperrt)'),
gf_gbl_vertrieb_sperr_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den GF gesperrt sind (1 = gesperrt)'),
anz_einkaufswagen_boxen BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Einkaufswagen Boxen. Wird manuell von VT INTEGER erhoben.'),
anz_heissgetraenke_automaten BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Heißgetränkeautomaten. Wird manuell von VT INTEGER erhoben.'),
anz_t_zellen_backshop BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Tiefkühlplätze beim Backshop. Wird manuell von VT INTEGER erhoben.'),
haeufigste_ultra_frische_listungsstufe_kz STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe der SOK Abteilung Ultra Frische in der Filiale an.'),
haeufigste_mopro_listungsstufe_kz STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe des SOK Fima Bausteins Mopro in der FIliale an.'),
haeufigste_tiko_listungsstufe_kz STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe des SOK Fima Bausteins Tiko in der Filiale an.'),
haeufigste_trocken_listungsstufe_kz STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe der SOK Kategorie Trockenachsen Food in der Filiale an.'),
haeufigste_nonfood_listungsstufe_kz STRING(50)
OPTIONS(description='Gibt die häufigste Listungsstufe der Food / Non Food Kategorie Non Food in der Filiale an.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id) NOT ENFORCED
) OPTIONS(description='VIS - denormalisierte Stammdaten der Märkte zur Performancesteigerung');