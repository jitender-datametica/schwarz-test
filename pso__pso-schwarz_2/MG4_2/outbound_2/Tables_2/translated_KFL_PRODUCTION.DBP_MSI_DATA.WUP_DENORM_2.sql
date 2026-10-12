CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.wup_denorm_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer aus t001w.werks'),
bed_fleisch_fg INTEGER NOT NULL OPTIONS(description='Bedienkonzept Fleisch Flag'),
bed_fleisch_dat DATE OPTIONS(description='Datum, ab dem das aktuelle Bedienkonzept gültig ist'),
bed_wurst_fg INTEGER NOT NULL OPTIONS(description='Bedienkonzept Wurst Flag'),
bed_wurst_dat DATE OPTIONS(description='Bedienkonzept Wurst Datum'),
bed_gefl_fg INTEGER NOT NULL OPTIONS(description='Bedienkonzept Geflügel Flag'),
bed_gefl_dat DATE OPTIONS(description='Bedienkonzept Geflügel Datum'),
bed_kaese_fg INTEGER NOT NULL OPTIONS(description='Bedienkonzept  Käse Flag'),
bed_kaese_dat DATE OPTIONS(description='Bedienkonzept  Käse Datum'),
bed_fisch_id INTEGER NOT NULL
OPTIONS(description='Bedienkonzept Fisch. ID verweist auf SB, Bedienung oder Bedienung/SB'),
bed_fisch_dat DATE OPTIONS(description='Bedienkonzept Fisch Datum'),
bed_feink_fg INTEGER NOT NULL OPTIONS(description='Bedienkonzept Feinkost Flag'),
bed_feink_dat DATE OPTIONS(description='Bedienkonzept Feinkost Datum'),
bed_bulk_fg INTEGER NOT NULL OPTIONS(description='Bedienkonzept  Bulkfood Flag'),
bed_bulk_dat DATE OPTIONS(description='Bedienkonzept  Bulkfood Datum'),
bed_bedins_fg INTEGER NOT NULL OPTIONS(description='Bedienkonzept Bedieninsel Flag'),
bed_bedins_dat DATE OPTIONS(description='Bedienkonzept Bedieninsel Datum'),
bed_imbiss_fg INTEGER NOT NULL OPTIONS(description='Bedienkonzept Imbiss Flag'),
bed_imbiss_dat DATE OPTIONS(description='Bedienkonzept Imbiss Datum'),
bed_backshop_fg INTEGER NOT NULL OPTIONS(description='Bedienungskonzept Backshop Flag'),
bed_backshop_dat DATE OPTIONS(description='Bedienungskonzept Backshop Datum'),
backshop_system STRING(40) COLLATE 'und:ci' OPTIONS(description='Backshop System, z.Bsp. Discount'),
leergut_system STRING(40) COLLATE 'und:ci' OPTIONS(description='Leergut System, z.Bsp. Leergutautomat'),
anz_leergutautomaten INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der Leergutautomaten'),
glv_land_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID des GLV Land_2'),
stv_glv_land_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID des stellvertretenden GLV Land_2'),
gl_vertrieb_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter_id der/des GL Vertrieb'),
gf_gbl_vertrieb_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der/des GF_2/GBL Vertrieb'),
vkl_id INTEGER NOT NULL
OPTIONS(description='Mitarbeiter ID der/des Verkaufsleiters. Achtung: abweichend von der bisher im DWH generierten VKL_2-ID'),
hausleiter_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID des Hausleiters'),
wbl_food_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Food'),
wbl_frische_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter Id der Warenbereichsleitung Frische'),
wbl_nonfood_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Nonfood'),
wbl_kasse_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der Warenbereichsleitung Kasse'),
frische_manager_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID des Frischemanagements'),
regionale_psb_id INTEGER NOT NULL OPTIONS(description='Mitarbeiter ID der regionalen Personalsachbearbeitung'),
tankstelle_vorh_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag ist gesetzt, wenn eine_2 Tankstelle vorhanden ist. Kommt aus techn_platz_ebene_2'),
tankstelle_eigen_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag, ob eine_2 Tankstelle in Eigenverwendung. 1 = eigen'),
ma_vermietung_id INTEGER OPTIONS(description='Mitarbeiter Vermietung. Referenz zur Tabelle l_ma.'),
eigentum_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Eigentum Flag. Wenn = 1, dann Eigentum, 0 = Miete'),
dat_letzte_reorga DATE
OPTIONS(description='Datum der letzten großen Umbaumaßnahme. Wird aus cpr_cl_punkt_termin_2 ermittelt.'),
parkhaus_kz INTEGER NOT NULL
OPTIONS(description='Parkhaus Kennzeichen. Kann die Werte 0= kein Parkhaus, 1 = Parkhaus, -1 = unbekannt annehmen. Die Information wird aus der Spalte betreiberart_bez der Tabelle l_ginfo_betreiberart_2 ermittelt'),
getraenkemarkt_kz INTEGER NOT NULL
OPTIONS(description='Kennzeichen für einen separaten Getränkemarkt. Kann die Werte 0= kein Getränkemarkt. 1 = Getränkemarkt. -1 = unbekannt annehmen. Die Information wird aus der Spalte betreiberart_bez der Tabelle l_ginfo_betreiberart_2 ermittelt'),
anz_aufzuege INTEGER NOT NULL
OPTIONS(description='Anzahl Aufzüge (gesamt) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
anz_rollsteige INTEGER NOT NULL
OPTIONS(description='Anzahl Rollsteige (gesamt) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
anz_aufzuege_intern INTEGER NOT NULL
OPTIONS(description='Anzahl Aufzüge (nur innerhalb der Verkaufsfläche) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
anz_rollsteige_intern INTEGER NOT NULL
OPTIONS(description='Anzahl Rollsteige (nur innerhalb der Verkaufsfläche) pro Markt. Wird berechnet aus der IOS-Versorgung (598 VAUS) der EQUI-Schnittstelle.'),
untervermietung_kz STRING(20) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
untervermietung_text STRING(160) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
untervermietung_freitext STRING(160) COLLATE 'und:ci'
OPTIONS(description='Quelle sind interne Mietverträge(mehrere Angaben zur Filiale möglich) - sonst an keiner Stelle im DWH vorhanden'),
hausleiter_sperr_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den Hausleiter gesperrt sind (1 = gesperrt)'),
vkl_sperr_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den VKL_2 gesperrt sind (1 = gesperrt)'),
gf_gbl_vertrieb_sperr_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag zeigt an, ob TEKU-Berichte für den GF_2 gesperrt sind (1 = gesperrt)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
anz_einkaufswagen_boxen INTEGER
OPTIONS(description='Anzahl der Einkaufswagen Boxen. Wird manuell von VT INTEGER erhoben.'),
anz_heissgetraenke_automaten INTEGER
OPTIONS(description='Anzahl der Heißgetränkeautomaten. Wird manuell von VT INTEGER erhoben.'),
anz_t_zellen_backshop INTEGER
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
PRIMARY KEY (mandant_id, wup_id) NOT ENFORCED
) OPTIONS(description='VIS - denormalisierte Stammdaten der Märkte zur Performancesteigerung');