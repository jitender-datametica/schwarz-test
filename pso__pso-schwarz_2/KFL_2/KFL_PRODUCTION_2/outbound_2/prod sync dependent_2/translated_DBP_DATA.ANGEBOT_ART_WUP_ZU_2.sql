CREATE OR REPLACE TABLE kfl_production_dbp_data.angebot_art_wup_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
verkaufsorganisation_id STRING(4) NOT NULL
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
art_basismenge_einh_id STRING(3) OPTIONS(description='Einheit der Basismenge des Artikels, bspw. KG, L, ST, etc.'),
art_typ_cd STRING(10)
OPTIONS(description='Code gibt den Typ des Artikels an: O = Orphan (Artikel_2 hat keine mutter_wb_id), C = Child (Artikel_2 hat eine_2 mutter_wb_id), M = Mother (Artikel_2 ist die mutter_wb_id).'),
art_gtin_id INTEGER OPTIONS(description='GTIN des angebotenen Artikels in der Filiale'),
mutter_wb_id INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
art_posten_fg INTEGER NOT NULL
OPTIONS(description='Postenkennzeichen für Artikel_2, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem Artikelstamm, da dort nicht historisiert.'),
art_prio_nr INTEGER OPTIONS(description='Priorisiert den Artikel_2 innerhalbt der Produktgruppe ()'),
art_theken_verkauf_fg INTEGER
OPTIONS(description='Flag gibt an, ob der Artikel_2 für das Angebot_2 in dem Markt an der Theke verkauft wird (1) oder nicht (0).'),
art_nis_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob Artikel_2 sich neu (1) im Sortiment befindet oder nicht (0) '),
art_national_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob es sich um einen regionalen / nationalen Artikel_2 handelt (1) oder in mehreren Ländern vorhanden ist (0).'),
art_export_werbemittel_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob der Artikel_2 an die Werbemittel übertragen werden soll (1) oder nicht (0)'),
art_preisangabe_cd STRING(10)
OPTIONS(description='Code gibt an welche Gesetze der Preisangabeverordnung eingehalten werden müssen. Je nach Verderblichkeit des Artikels können unterschiedliche Gesetze gelten: A = nicht verderblich (bspw. Non Food), B = verderblich, C verderblich mit längerer Gültigkeit'),
art_werbe_prod_gruppe_name STRING(500)
OPTIONS(description='Name der Werbe-Produktgruppe.Ein  Artikel_2 kann für Angebote alternativen Produktgruppen zugeordnet werden. Diese sind nicht vergleichbar zu den Warengruppen im DWH.'),
gp_id INTEGER OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
opv_markt_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob das Angebot_2 in den Märkten ohne Preisvorteil (1) angezeigt wird.'),
opv_prospekt_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob das Angebot_2 in den Prospekten ohne Preisvorteil (1) angezeigt wird.'),
anz_bonuskauf_bezahlt INTEGER
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, kann hier die Anzahl der Artikel_2 stehen, die bezahlt werden müssen (Betrifft nicht alle Bonuskauf-Typen).'),
anz_bonuskauf_kauf INTEGER
OPTIONS(description='Handelt es sich bei dem Angebot_2  um einen Bonuskauf, kann hier die Anzahl an Artikeln stehen, die gekauft werden müssen. (Betrifft nicht alle Bonuskauf-Typen)'),
anz_bonuskauf_gratis INTEGER
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, kann hier die Anzahl an Artikeln stehen, die kostenlos erhalten werden. (Betrifft nicht alle Bonuskauf Typen)'),
proz_bonuskauf_rabatt NUMERIC(29,5)
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf und der Rabatt ist prozentbezogen, kann hier der Rabatt in Prozent stehen (Betrifft nicht alle Bonuskauf Typen).'),
betrag_bonuskauf_rabatt NUMERIC(29,5)
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf und der Rabatt ist absolut, kann hier der Wert des Rabattes stehen (Betrifft nicht alle Bonuskauf Typen).'),
betrag_bonuskauf_min NUMERIC(29,5)
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, kann hier der Mindestbetrag (monetär) stehen, der erreicht werden muss, um die Bedingung für den Bonusby zu erfüllen (Betrifft nicht alle Bonuskauf Typen).'),
menge_bonuskauf_min NUMERIC(29,5)
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, kann hier die Mindestmenge (absatzbezogen) stehen, die erreicht werden muss, um die Bedingung für den Bonusbuy zu erfüllen (Betrifft nicht alle Bonuskauf Typen).'),
bonuskauf_bedingung_id INTEGER
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, ID der Bonuskauf Bedingung: Gibt an, ob der Kunde den Artikel_2 kaufen / bezahlen muss (1) oder ihn als Bonus zum Kauf erhält (2).'),
bonuskauf_dimension_id STRING(10)
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, ID der Bonuskauf Dimension: Gibt an, ob der Rabatt für ein Produkt oder mehrere Produkte gültig ist: 1 = Produkt, 2 = Produktgruppe, 3 = Warengruppe.'),
bonuskauf_produktvariante_id STRING(10)
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, ID der Bonuskauf Produktvariante: Gibt an, in welcher Ausprägung die Produkte kombiniert werden müssen um den Rabatt zu erhalten: 0 = irgendein Produkt, 1 = selbes Produkt, 2, verschiedene Produkte'),
bonuskauf_rabattzuordnung_id INTEGER
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, ID der Bonuskauf Rabattzuordnung: Gibt an, für welches Produkt oder für welche Produkte der Rabatt gilt: 1 = alle Produkte, 2 = günstigstes Produkt, 3 = teuerstes Produkt.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
rabatt_typ_id INTEGER
OPTIONS(description='ID des Rabatt Typs. Gibt die Art_2 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'),
preis_vk_brutto NUMERIC(29,5) OPTIONS(description='Regulärer Verkaufspreis des Artikels in dem Markt.'),
preis_vk_brutto_aktion NUMERIC(29,5) OPTIONS(description='Angebotspreis des Artikels in dem Markt.'),
preis_vk_brutto_normalisiert NUMERIC(29,5)
OPTIONS(description='Auf die Basiseinheit normalisierter Preis des Artikels in dem Markt. Bsp.: Artikel_2 enthält 2,5 Liter, Preis wird für 1 Liter berechnet.'),
preis_vk_brutto_stk NUMERIC(29,5)
OPTIONS(description='Regulärer Verkaufspreis des Artikels pro Stück. Besteht der Artikel_2 nur aus einem Stück entspricht dies dem preis_vk_brutto. Bspw. Preis einer einzelnen Flasche bei einer Kiste.'),
preis_vk_brutto_aktion_stk NUMERIC(29,5)
OPTIONS(description='Angebotspreis des Artikels pro Stück. Besteht der Artikel_2 nur aus einem Stück entspricht dies dem preis_vk_brutto_aktion. Bspw. Preis einer Flasche in einer Kiste.'),
proz_preisnachlass NUMERIC(29,5)
OPTIONS(description='Preisnachlass des Angebotspreises im Vergleich zum regulären Verkaufspreises in Prozent.'),
menge_prog_scm NUMERIC(29,5)
OPTIONS(description='Prognostizierte Werbemengen von SCM (Supply Chain Management) die benötigt werden und beim Lieferanten bestellt werden sollen.'),
menge_prog_am NUMERIC(29,5)
OPTIONS(description='Prognostiziertes Ziel der Absatzmenge von AM (Aktionsmanagement_2) durch Controlling vorgegeben.'),
betrag_prog_rohertrag_scm NUMERIC(29,5)
OPTIONS(description='Prognostizierter Rohertrag, der sich aus der SCM (Supply Chain Management) Prognose ergibt.'),
betrag_prog_pv NUMERIC(29,5) OPTIONS(description='Prognostizierter Wert der Preisveränderung (PV).'),
betrag_prog_umsatz_am NUMERIC(29,5)
OPTIONS(description='Prognostiziertes Umsatzziel von AM (Aktionsmanagemen), durch Controlling vorgegeben.'),
betrag_prog_umsatz_scm NUMERIC(29,5)
OPTIONS(description='Prognostiziertes Umsatzziel von SCM (Supply Chain Management)'),
preis_ek_nettonetto NUMERIC(29,5) OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto.'),
proz_art_rabatt NUMERIC(29,5)
OPTIONS(description='Zusätzlich verhandelter Rabatt mit den Lieferanten in Prozent aus PMR. ZAR5'),
preis_ek_mep_vor_fwu NUMERIC(29,5)
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt.'),
preis_ek_nettonetto_rabatt NUMERIC(29,5)
OPTIONS(description='Mit dem verhandelten Rabatt neu berechneter EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto.'),
preis_ek_mep_vor_fwu_rabatt NUMERIC(29,5)
OPTIONS(description='Mit dem Rabatt neu berechneter Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt.'),
proz_prog_spanne_ek_nettonetto NUMERIC(29,5)
OPTIONS(description='Mit EK netto netto berechnete prognostizierte Spanne (Rohertrag / Kassenumsatz) in Prozent.'),
proz_prog_spanne_ek_mep_vor_fwu NUMERIC(29,5)
OPTIONS(description='Mit EK MEP vor FWU berechnete prognostizierte Spanne (Rohertrag / Kassenumsatz) in Prozent.'),
proz_prog_spanne_ek_einstandspreis NUMERIC(29,5)
OPTIONS(description='Mit EK einstandspreis berechnete prognostizierte Spanne (Rohertrag / Kassenumsatz) in Prozent.'),
ek_preis_ermittlung_rabatt_typ_id INTEGER
OPTIONS(description='Ziel Rabatt Typ aus PMR für ZAR5 Prozess. Sagt aus, welcher Rabatttyp bei der Ermittlung der Einkaufspreise für den angebotenen Artikel_2 verwendet werden soll. 1 = Target EK Preism 2 = Target ZAR5'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_nr, art_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='Tabellle enthält Daten, wenn Angebote für Artikel_2 in den Märkten verwendet werden.');