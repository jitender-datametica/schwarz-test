CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.SAL_KMO (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
KJMO INTEGER NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
ARTHIERTYP_ID INTEGER OPTIONS(description='Artikel - Hierarchie - Typ - ID. Kennzeichnet'),
WG_ID INTEGER OPTIONS(description='ID der Warengruppe'),
WUG_ID INTEGER OPTIONS(description='Warenuntergruppe (WGI)'),
ART_STATUS STRING(2) COLLATE 'und:ci'
OPTIONS(description='Wenn Artikel aktuell in mind. einem Markt gelistet ist (Abfrage über dbp_data.sternchen_logik sum(anzahl_markt_listung)>0), dann ist das Flag gesetzt'),
GP_ID INTEGER OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
GP_NAME STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Geschäftspartners'),
EIGENMARKE_ID STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Klassikartikel)'),
BIO_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Biosiegel Flag EU, es gibt auch noch ein bio_fg_cz (Kürzel: BIO)'),
VEGAN_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Vegan Flag aus vgn (Kürzel: VGN)'),
POSTEN_FOOD STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel, die nicht ständig im Sortiment sind'),
POSTEN_NONFOOD STRING(1) COLLATE 'und:ci' NOT NULL,
GLUTEN_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Gluten-freie Artikel'),
MWST NUMERIC(12,2) NOT NULL OPTIONS(description='Mehrwertsteuersatz'),
DISC_PE INTEGER OPTIONS(description='Discount Kennzeichen PE (Herkunft noch klären!)'),
DISC_MARKE INTEGER,
LACTOSE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Lactosefreie Artikel'),
K_LISTUNG STRING(4) COLLATE 'und:ci' NOT NULL,
UMRECH_FAKTOR_BEST NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungsfaktor für eine alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
UMRECH_FAKTOR_AUSG NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungsfaktor für eine alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
MHD_ZEITRAUM INTEGER
OPTIONS(description='Dieses Feld gibt den standardmässigen Mindesthaltbarkeitszeitraum für diesen Artikel in Tagen an.'),
MHD_ZEITRAUM_DZ INTEGER,
K1_ARTBEW_MENGE NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K1 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
K1_ANZ_KJWO_WUG_ABSATZ INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K1 für diesen Artikel'),
K2_ARTBEW_MENGE NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel reduziert um zurückgegebene Artikel'),
K2_ANZ_KJWO_WUG_ABSATZ INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K2 für diesen Artikel'),
K3_ARTBEW_MENGE NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K3 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
K3_ANZ_KJWO_WUG_ABSATZ INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K3 für diesen Artikel'),
K4_ARTBEW_MENGE NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K4 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
K4_ANZ_KJWO_WUG_ABSATZ INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K4 für diesen Artikel'),
K5_ARTBEW_MENGE NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung für die Listung K5 (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
K5_ANZ_KJWO_WUG_ABSATZ INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz in der Listung K5 für diesen Artikel'),
TOTAL_ARTBEW_MENGE NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung (sm_id(kann in Stück oder bei Gewichtsartikeln in KG sein) '),
TOTAL_ANZ_KJWO_WUG_ABSATZ INTEGER OPTIONS(description='Anzahl Wochen mit Umsatz für diesen Artikel'),
TOTAL_ARTBEW_MENGE_VJ NUMERIC(18,3),
TOTAL_ARTBEW_MENGE_SA NUMERIC(18,3),
TOTAL_ANZ_KJWO_WUG_ABSATZ_SA INTEGER,
TOTAL_ANZ_TAGE_WUG_ABSATZ_SA INTEGER,
TOTAL_ARTBEW_MENGE_AF NUMERIC(18,3),
TOTAL_ANZ_KJWO_WUG_ABSATZ_AF INTEGER,
SCHNELLDREHERQUOTE NUMERIC(29,5) NOT NULL OPTIONS(description='Anzahl Wochen mit Absatz/Anzahl Wochen mit Listung'),
PROZENTUAL_ABSATZ_SA NUMERIC(29,5) NOT NULL OPTIONS(description='Anteil Sonderaktionsmege in Prozent'),
TOTAL_ROHERTRAG NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis ) für den kompletten Umsatz.'),
TOTAL_ROHERTRAG_VJ NUMERIC(18,4) NOT NULL,
TOTAL_ROHERTRAG_AF NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis) für den aktionsfreien Umsatz (bewart_id 1001) / total_artbew_menge'),
TOTAL_ROHERTRAG_SA NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis) für den Sonderaktions-Umsatz (bewart_id 1002) / total_artbew_menge'),
ROHERTRAG_EINHEIT NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis ) für den kompletten Umsatz / total_artbew_menge'),
ROHERTRAG_EINHEIT_AF NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis ) für den kompletten Umsatz'),
ROHERTRAG_EINHEIT_SA NUMERIC(18,4) NOT NULL
OPTIONS(description='Umsatz_netto abzgl. EK_MEP (Markteinstandspreis ) für den kompletten Umsatz'),
ABSCHRIFTBETRAG_NETTO_OWERBUNG NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Abschriftenbetrag ohne MWSt -  aus Marktabschriften COI ohne Werbung'),
EK_KB_STAMM NUMERIC(18,4) NOT NULL,
VK_BRUTTO_PK1 NUMERIC(18,3)
OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
VK_BRUTTO_PK4 NUMERIC(18,3)
OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
VK_NETTO_PK1 NUMERIC(18,3)
OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
VK_NETTO_PK4 NUMERIC(18,3)
OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
TOTAL_UMSATZ_NETTO NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
TOTAL_UMSATZ_NETTO_AF NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
TOTAL_UMSATZ_NETTO_SA NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
TOTAL_ANZ_MARKT INTEGER
OPTIONS(description='Gibt an wie viele Märkte im rollierenden Jahr den betrachteten Artikel abverkauft haben'),
ANZ_KJWO_WUP_LISTUNG INTEGER
OPTIONS(description='Anzahl Wochen in denen dieser Artikel im abgefragten Zeitraum (12 Monate) gelistet wurde'),
ANZ_WUP_LISTUNG INTEGER
OPTIONS(description='Anzahl Märkte die diesen Artikel im abgefragten Zeitraum (12 Monate) gelistet haben'),
LAGER_PROZENT INTEGER DEFAULT 100 NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel vom Lager ausgeliefert wird'),
KOL_LA_BZW NUMERIC(29,5) NOT NULL,
KOL_BST_BZW NUMERIC(29,5) NOT NULL,
SPANNE_EK1 NUMERIC(29,5) NOT NULL,
SPANNE_EK4 NUMERIC(29,5) NOT NULL,
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ZEK_ID STRING(3) OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
PRIMARY KEY (MANDANT_ID, ART_ID, KJMO) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Aggregat für die Sortimentsausschussliste im Einkauf. (KMO)');