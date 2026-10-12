--==============================================================
-- Table: sal_kmo_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sal_kmo_2
   generated from Powerdesigner on Montag, 4. September 2023 17:07:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sal_kmo_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_2 eines Kalenderjahres, Format JJJJMM'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
arthiertyp_id BIGNUMERIC(38,0) OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID. Kennzeichnet'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0) OPTIONS(description='Warenuntergruppe (WGI)'),
art_status STRING(2) COLLATE 'und:ci'
OPTIONS(description='Wenn Artikel_2 aktuell in mind. einem Markt gelistet ist (Abfrage über dbp_data.sternchen_logik_2 sum(anzahl_markt_listung)>0), dann ist das Flag gesetzt'),
gp_id BIGNUMERIC(38,0) OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
gp_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Geschäftspartners'),
zek_id STRING(3) OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
eigenmarke_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Klassikartikel)'),
bio_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Biosiegel Flag EU, es gibt auch noch ein bio_fg_cz (Kürzel: BIO)'),
vegan_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Vegan Flag aus vgn (Kürzel: VGN)'),
posten_food STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel_2, die nicht ständig im Sortiment sind'),
posten_nonfood STRING(1) COLLATE 'und:ci' NOT NULL,
gluten_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Flag für Gluten-freie Artikel_2'),
mwst NUMERIC(12,2) NOT NULL OPTIONS(description='Mehrwertsteuersatz'),
disc_pe BIGNUMERIC(38,0) OPTIONS(description='Discount Kennzeichen PE (Herkunft noch klären!)'),
disc_marke BIGNUMERIC(38,0),
lactose_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Flag für Lactosefreie Artikel_2'),
k_listung STRING(4) COLLATE 'und:ci' NOT NULL,
umrech_faktor_best BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Umrechnungsfaktor für eine_2 alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
umrech_faktor_ausg BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Umrechnungsfaktor für eine_2 alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
mhd_zeitraum BIGNUMERIC(38,0)
OPTIONS(description='Dieses Feld gibt den standardmässigen Mindesthaltbarkeitszeitraum für diesen Artikel_2 in Tagen an.'),
mhd_zeitraum_dz BIGNUMERIC(38,0),
k1_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K1 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
k1_anz_kjwo_wug_absatz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K1 für diesen Artikel_2'),
k2_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel_2 reduziert um zurückgegebene Artikel_2'),
k2_anz_kjwo_wug_absatz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K2 für diesen Artikel_2'),
k3_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K3 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
k3_anz_kjwo_wug_absatz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K3 für diesen Artikel_2'),
k4_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K4 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
k4_anz_kjwo_wug_absatz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K4 für diesen Artikel_2'),
k5_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K5 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
k5_anz_kjwo_wug_absatz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K5 für diesen Artikel_2'),
total_artbew_menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
total_anz_kjwo_wug_absatz BIGNUMERIC(38,0) OPTIONS(description='Anzahl Wochen mit Umsatz für diesen Artikel_2'),
total_artbew_menge_vj NUMERIC(18,3),
total_artbew_menge_sa NUMERIC(18,3),
total_anz_kjwo_wug_absatz_sa BIGNUMERIC(38,0),
total_anz_tage_wug_absatz_sa BIGNUMERIC(38,0),
total_artbew_menge_af NUMERIC(18,3),
total_anz_kjwo_wug_absatz_af BIGNUMERIC(38,0),
schnelldreherquote BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Anzahl Wochen mit Absatz/Anzahl Wochen mit Listung'),
prozentual_absatz_sa BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Anteil Sonderaktionsmege in Prozent'),
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
OPTIONS(description='Abschriftenbetrag ohne MWSt -  aus Marktabschriften_2 COI ohne Werbung'),
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
total_anz_markt BIGNUMERIC(38,0)
OPTIONS(description='Gibt an wie viele Märkte im rollierenden Jahr den betrachteten Artikel_2 abverkauft haben'),
anz_kjwo_wup_listung BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Wochen in denen dieser Artikel_2 im abgefragten Zeitraum (12 Monate) gelistet wurde'),
anz_wup_listung BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Märkte die diesen Artikel_2 im abgefragten Zeitraum (12 Monate) gelistet haben'),
lager_prozent BIGNUMERIC(38,0) DEFAULT 100 NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_2 vom Lager ausgeliefert wird'),
kol_la_bzw BIGNUMERIC(38,5) NOT NULL,
kol_bst_bzw BIGNUMERIC(38,5) NOT NULL,
spanne_ek1 BIGNUMERIC(38,5) NOT NULL,
spanne_ek4 BIGNUMERIC(38,5) NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, kjmo) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Aggregat für die Sortimentsausschussliste im Einkauf. (KMO)');