CREATE OR REPLACE TABLE kfl_production_dbp_data.sal_int_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
owg_id INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe (ohne Arthiertyp_2, da eigenes Attribut im FE)'),
wg_id INTEGER NOT NULL OPTIONS(description='Warengruppe ID (ohne Arthiertyp_2, da eigenes Attribut im FE)'),
wug_id INTEGER NOT NULL OPTIONS(description='Warenuntergruppe ID (ohne Arthiertyp_2, da eigenes Attribut im FE)'),
k1_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der SST\""K1\"" (as is Sicht WRF6)'),
k1_anz_wup_absatz INTEGER OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K1\"" (as is Sicht WRF6)'),
k1_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der SST\""K1\"" (as is Sicht WRF6)'),
k2_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der SST\""K2\"" (as is Sicht WRF6)'),
k2_anz_wup_absatz INTEGER OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K2\"" (as is Sicht WRF6)'),
k2_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der SST\""K2\"" (as is Sicht WRF6)'),
k3_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der SST\""K3\"" (as is Sicht WRF6)'),
k3_anz_wup_absatz INTEGER OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K3\"" (as is Sicht WRF6)'),
k3_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der SST\""K3\"" (as is Sicht WRF6)'),
k4_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der SST\""K4\"" (as is Sicht WRF6)'),
k4_anz_wup_absatz INTEGER OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K4\"" (as is Sicht WRF6)'),
k4_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der SST\""K4\"" (as is Sicht WRF6)'),
k5_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der SST\""K5\"" (as is Sicht WRF6)'),
k5_anz_wup_absatz INTEGER OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K5\"" (as is Sicht WRF6)'),
k5_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der SST\""K5\"" (as is Sicht WRF6)'),
ost_basis_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der Region_2 ost_basis (as is Sicht Kreistyp)'),
ost_basis_anz_wup_absatz INTEGER
OPTIONS(description='Anzahl Märkte mit Abverkauf der Region_2 ost_basis (as is Sicht Kreistyp)'),
ost_basis_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der Region_2 ost_basis (as is Sicht Kreistyp)'),
ost_gross_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der Region_2 ost_gross (as is Sicht Kreistyp)'),
ost_gross_anz_wup_absatz INTEGER
OPTIONS(description='Anzahl Märkte mit Abverkauf der Region_2 ost_gross (as is Sicht Kreistyp)'),
ost_gross_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der Region_2 ost_gross (as is Sicht Kreistyp)'),
sued_ost_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der Region_2 sued_ost (as is Sicht Kreistyp)'),
sued_ost_anz_wup_absatz INTEGER
OPTIONS(description='Anzahl Märkte mit Abverkauf der Region_2 sued_ost (as is Sicht Kreistyp)'),
sued_ost_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der Region_2 sued_ost (as is Sicht Kreistyp)'),
sued_west_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der Region_2 sued_west (as is Sicht Kreistyp)'),
sued_west_anz_wup_absatz INTEGER
OPTIONS(description='Anzahl Märkte mit Abverkauf der Region_2 sued_west (as is Sicht Kreistyp)'),
sued_west_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der Region_2 sued_west (as is Sicht Kreistyp)'),
west_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der Region_2 west (as is Sicht Kreistyp)'),
west_anz_wup_absatz INTEGER OPTIONS(description='Anzahl Märkte mit Abverkauf der Region_2 west (as is Sicht Kreistyp)'),
west_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der Region_2 west (as is Sicht Kreistyp)'),
nord_artbew_menge NUMERIC(29,3) OPTIONS(description='Absatz der Region_2 nord (as is Sicht Kreistyp)'),
nord_anz_wup_absatz INTEGER OPTIONS(description='Anzahl Märkte mit Abverkauf der Region_2 nord (as is Sicht Kreistyp)'),
nord_anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa) der Region_2 nord (as is Sicht Kreistyp)'),
total_artbew_menge NUMERIC(29,3) OPTIONS(description='Summe Absatz'),
total_artbew_menge_sa NUMERIC(29,3) OPTIONS(description='Summe Absatz SA'),
total_artbew_menge_vj NUMERIC(29,3) OPTIONS(description='Summe Absatz VJ'),
total_umsatz_netto NUMERIC(29,4) OPTIONS(description='Summe Kassenumsatz'),
total_umsatz_netto_sa NUMERIC(29,4) OPTIONS(description='Summe Kassenumsatz SA'),
total_umsatz_netto_af NUMERIC(29,4) NOT NULL OPTIONS(description='Summe Kassenumsatz AF'),
total_rohertrag NUMERIC(29,4) OPTIONS(description='Summe Rohertrag MEP'),
total_rohertrag_sa NUMERIC(29,4) OPTIONS(description='Summe Rohertrag MEP SA'),
total_rohertrag_af NUMERIC(29,4) OPTIONS(description='Summe Rohertrag MEP AF'),
total_rohetrag_vj NUMERIC(29,4) NOT NULL OPTIONS(description='Summe Rohertrag MEP VJ'),
total_rohertrag_olk NUMERIC(29,4) OPTIONS(description='Summe Rohertrag MEP ohne Logistikkosten'),
total_rohertrag_olk_sa NUMERIC(29,4) OPTIONS(description='Summe Rohertrag MEP ohne Logistikkosten SA'),
total_rohertrag_olk_af NUMERIC(29,4) OPTIONS(description='Summe Rohertrag MEP ohne Logistikkosten AF'),
total_rohertrag_olk_vj NUMERIC(29,4) OPTIONS(description='Summe Rohertrag MEP ohne Logistikkosten Vorjahr'),
abschriftsbetrag_ohne_werbung_netto NUMERIC(29,2) OPTIONS(description='Summe Abschriften_2 ohne AKZ -1 VK_2 netto'),
anz_wup_absatz INTEGER OPTIONS(description='Anzahl Märkte mit Abverkauf'),
anz_wup_listung INTEGER OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa)'),
anz_akt_wup_listung INTEGER NOT NULL
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag_2 Mo-Sa).Täglich berechnet und bezieht sich auf Mandant_2 und Artikel.'),
listung_min_1_wup_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag\""1\"" wenn mindestens 1 Markt gelistet (as is)-Täglich berechnet und bezieht sich auf Mandant_2 und Artikel.'),
listung_min_1_sst_durchg_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag\""1\"" wenn in mindestens 1 SST in allen Märkten gelistet (DWH Sternchenlogik)-Täglich berechnet und bezieht sich auf Mandant_2 und Artikel.'),
listung_min_1_sst_durchg_mvke_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag\""1\"" wenn in SST-Listung gepflegt (laut MVKE_2)-Täglich berechnet und bezieht sich auf Mandant_2 und Artikel.'),
listung_min_1_region_durchg_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag\""1\"" wenn in mindestens 1 Region_2 in allen Märkten gelistet (DWH Sternchenlogik)-Täglich berechnet und bezieht sich auf Mandant_2 und Artikel.'),
listung_min_1_region_durchg_baustein_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag\""1\"" wenn in mindestens 1 Region_2 gelistet (über vom FB definierte Bausteinnummern)-Täglich berechnet und bezieht sich auf Mandant_2 und Artikel.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, kjwo) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Aggregat für die Sortimentsausschussliste im Einkauf. Die Granularität der Tabelle ist uneinheitlich, weil FE Report inperfromant war und es wurde entschieden alles was für Report relevant in der Tabelle gepackt. Einige Spalten beziehen sich nur auf Mandant_2 und Artikel.');