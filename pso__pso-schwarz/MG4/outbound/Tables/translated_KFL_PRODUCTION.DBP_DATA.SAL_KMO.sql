CREATE OR REPLACE TABLE kfl_production_dbp_data.sal_kmo (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
kjmo INTEGER NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
arthiertyp_id INTEGER OPTIONS(description='Artikel - Hierarchie - Typ - ID. Kennzeichnet'),
wg_id INTEGER OPTIONS(description='ID der Warengruppe'),
wug_id INTEGER OPTIONS(description='Warenuntergruppe (WGI)'),
art_status STRING(2) COLLATE 'und:ci'
OPTIONS(description='Wenn Artikel aktuell in mind. einem Markt gelistet ist (Abfrage über dbp_data.sternchen_logik sum(anzahl_markt_listung)>0), dann ist das Flag gesetzt'),
gp_id INTEGER OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
gp_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Geschäftspartners'),
eigenmarke_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Klassikartikel)'),
bio_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Biosiegel Flag EU, es gibt auch noch ein bio_fg_cz (Kürzel: BIO)'),
vegan_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Vegan Flag aus vgn (Kürzel: VGN)'),
posten_food STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel, die nicht ständig im Sortiment sind'),
posten_nonfood STRING(1) COLLATE 'und:ci' NOT NULL,
gluten_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Gluten-freie Artikel'),
mwst NUMERIC(12,2) NOT NULL OPTIONS(description='Mehrwertsteuersatz'),
disc_pe INTEGER OPTIONS(description='Discount Kennzeichen PE (Herkunft noch klären!)'),
disc_marke INTEGER,
lactose_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Lactosefreie Artikel'),
k_listung STRING(4) COLLATE 'und:ci' NOT NULL,
umrech_faktor_best NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungsfaktor für eine alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
umrech_faktor_ausg NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungsfaktor für eine alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
mhd_zeitraum INTEGER
OPTIONS(description='Dieses Feld gibt den standardmässigen Mindesthaltbarkeitszeitraum für diesen Artikel in Tagen an.'),
mhd_zeitraum_dz INTEGER,
k1_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K1 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
k1_anz_kjwo_wug_absatz INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K1 für diesen Artikel'),
k2_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel reduziert um zurückgegebene Artikel'),
k2_anz_kjwo_wug_absatz INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K2 für diesen Artikel'),
k3_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K3 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
k3_anz_kjwo_wug_absatz INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K3 für diesen Artikel'),
k4_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K4 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
k4_anz_kjwo_wug_absatz INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K4 für diesen Artikel'),
k5_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K5 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
k5_anz_kjwo_wug_absatz INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K5 für diesen Artikel'),
total_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
total_anz_kjwo_wug_absatz INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz für diesen Artikel'),
total_artbew_menge_vj NUMERIC(18,3),
total_artbew_menge_sa NUMERIC(18,3),
total_anz_kjwo_wug_absatz_sa INTEGER,
total_anz_tage_wug_absatz_sa INTEGER,
total_artbew_menge_af NUMERIC(18,3),
total_anz_kjwo_wug_absatz_af INTEGER,
schnelldreherquote NUMERIC(29,5) NOT NULL OPTIONS(description='Anzahl Wochen mit Absatz/Anzahl Wochen mit Listung'),
prozentual_absatz_sa NUMERIC(29,5) NOT NULL OPTIONS(description='Anteil Sonderaktionsmege in Prozent'),
total_rohertrag NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis ) für den kompletten Umsatz.'),
total_rohertrag_vj NUMERIC(18,4) NOT NULL,
total_rohertrag_af NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis) für den aktionsfreien Umsatz (bewart_id 1001) / total_artbew_menge'),
total_rohertrag_sa NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis) für den Sonderaktions-Umsatz (bewart_id 1002) / total_artbew_menge'),
rohertrag_einheit NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis ) für den kompletten Umsatz / total_artbew_menge'),
rohertrag_einheit_af NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis ) für den kompletten Umsatz'),
rohertrag_einheit_sa NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis ) für den kompletten Umsatz'),
abschriftbetrag_netto_owerbung NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Abschriftenbetrag ohne MWSt -  aus Marktabschriften COI ohne Werbung'),
ek_kb_stamm NUMERIC(18,4) NOT NULL,
vk_brutto_pk1 NUMERIC(18,3)
OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
vk_brutto_pk4 NUMERIC(18,3)
OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
vk_netto_pk1 NUMERIC(18,3)
OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
vk_netto_pk4 NUMERIC(18,3)
OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
total_umsatz_netto NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
total_umsatz_netto_af NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
total_umsatz_netto_sa NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
total_anz_markt INTEGER
OPTIONS(description='Gibt an wie viele Märkte im rollierenden Jahr den betrachteten Artikel abverkauft haben'),
anz_kjwo_wup_listung INTEGER
OPTIONS(description='Anzahl Wochen in denen dieser Artikel im abgefragten Zeitraum (12 Monate) gelistet wurde'),
anz_wup_listung INTEGER
OPTIONS(description='Anzahl Märkte die diesen Artikel im abgefragten Zeitraum (12 Monate) gelistet haben'),
lager_prozent INTEGER DEFAULT 100 NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel vom Lager ausgeliefert wird'),
kol_la_bzw NUMERIC(29,5) NOT NULL,
kol_bst_bzw NUMERIC(29,5) NOT NULL,
spanne_ek1 NUMERIC(29,5) NOT NULL,
spanne_ek4 NUMERIC(29,5) NOT NULL,
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
zek_id STRING(3) OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
PRIMARY KEY (mandant_id, art_id, kjmo) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Aggregat für die Sortimentsausschussliste im Einkauf. (KMO)');