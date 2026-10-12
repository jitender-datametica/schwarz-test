CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_art_wup_zu (mandant_id OPTIONS(description='Mandant im DWH'),
angebot_nr OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'), art_id
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
wup_id OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
verkaufsorganisation_id
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
art_basismenge_einh_id OPTIONS(description='Einheit der Basismenge des Artikels, bspw. KG, L, ST, etc.'), art_typ_cd
OPTIONS(description='Code gibt den Typ des Artikels an: O = Orphan (Artikel hat keine mutter_wb_id), C = Child (Artikel hat eine mutter_wb_id), M = Mother (Artikel ist die mutter_wb_id).'),
art_gtin_id OPTIONS(description='GTIN des angebotenen Artikels in der Filiale'), mutter_wb_id
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
art_posten_fg
OPTIONS(description='Postenkennzeichen für Artikel, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem Artikelstamm, da dort nicht historisiert.'),
art_prio_nr OPTIONS(description='Priorisiert den Artikel innerhalbt der Produktgruppe ()'), art_theken_verkauf_fg
OPTIONS(description='Flag gibt an, ob der Artikel für das Angebot in dem Markt an der Theke verkauft wird (1) oder nicht (0).'),
art_nis_fg OPTIONS(description='Flag gibt an, ob Artikel sich neu (1) im Sortiment befindet oder nicht (0) '),
art_national_fg
OPTIONS(description='Flag gibt an, ob es sich um einen regionalen / nationalen Artikel handelt (1) oder in mehreren Ländern vorhanden ist (0).'),
art_export_werbemittel_fg
OPTIONS(description='Flag gibt an, ob der Artikel an die Werbemittel übertragen werden soll (1) oder nicht (0)'),
art_preisangabe_cd
OPTIONS(description='Code gibt an welche Gesetze der Preisangabeverordnung eingehalten werden müssen. Je nach Verderblichkeit des Artikels können unterschiedliche Gesetze gelten: A = nicht verderblich (bspw. Non Food), B = verderblich, C verderblich mit längerer Gültigkeit'),
art_werbe_prod_gruppe_name
OPTIONS(description='Name der Werbe-Produktgruppe.Ein  Artikel kann für Angebote alternativen Produktgruppen zugeordnet werden. Diese sind nicht vergleichbar zu den Warengruppen im DWH.'),
gp_id OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), opv_markt_fg
OPTIONS(description='Flag gibt an, ob das Angebot in den Märkten ohne Preisvorteil (1) angezeigt wird.'),
opv_prospekt_fg
OPTIONS(description='Flag gibt an, ob das Angebot in den Prospekten ohne Preisvorteil (1) angezeigt wird.'),
anz_bonuskauf_bezahlt
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, kann hier die Anzahl der Artikel stehen, die bezahlt werden müssen (Betrifft nicht alle Bonuskauf-Typen).'),
anz_bonuskauf_kauf
OPTIONS(description='Handelt es sich bei dem Angebot  um einen Bonuskauf, kann hier die Anzahl an Artikeln stehen, die gekauft werden müssen. (Betrifft nicht alle Bonuskauf-Typen)'),
anz_bonuskauf_gratis
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, kann hier die Anzahl an Artikeln stehen, die kostenlos erhalten werden. (Betrifft nicht alle Bonuskauf Typen)'),
proz_bonuskauf_rabatt
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf und der Rabatt ist prozentbezogen, kann hier der Rabatt in Prozent stehen (Betrifft nicht alle Bonuskauf Typen).'),
betrag_bonuskauf_rabatt
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf und der Rabatt ist absolut, kann hier der Wert des Rabattes stehen (Betrifft nicht alle Bonuskauf Typen).'),
betrag_bonuskauf_min
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, kann hier der Mindestbetrag (monetär) stehen, der erreicht werden muss, um die Bedingung für den Bonusby zu erfüllen (Betrifft nicht alle Bonuskauf Typen).'),
menge_bonuskauf_min
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, kann hier die Mindestmenge (absatzbezogen) stehen, die erreicht werden muss, um die Bedingung für den Bonusbuy zu erfüllen (Betrifft nicht alle Bonuskauf Typen).'),
bonuskauf_bedingung_id
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, ID der Bonuskauf Bedingung: Gibt an, ob der Kunde den Artikel kaufen / bezahlen muss (1) oder ihn als Bonus zum Kauf erhält (2).'),
bonuskauf_dimension_id
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, ID der Bonuskauf Dimension: Gibt an, ob der Rabatt für ein Produkt oder mehrere Produkte gültig ist: 1 = Produkt, 2 = Produktgruppe, 3 = Warengruppe.'),
bonuskauf_produktvariante_id
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, ID der Bonuskauf Produktvariante: Gibt an, in welcher Ausprägung die Produkte kombiniert werden müssen um den Rabatt zu erhalten: 0 = irgendein Produkt, 1 = selbes Produkt, 2, verschiedene Produkte'),
bonuskauf_rabattzuordnung_id
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, ID der Bonuskauf Rabattzuordnung: Gibt an, für welches Produkt oder für welche Produkte der Rabatt gilt: 1 = alle Produkte, 2 = günstigstes Produkt, 3 = teuerstes Produkt.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), rabatt_typ_id
OPTIONS(description='ID des Rabatt Typs. Gibt die Art des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'),
preis_vk_brutto OPTIONS(description='Regulärer Verkaufspreis des Artikels in dem Markt.'), preis_vk_brutto_aktion
OPTIONS(description='Angebotspreis des Artikels in dem Markt.'), preis_vk_brutto_normalisiert
OPTIONS(description='Auf die Basiseinheit normalisierter Preis des Artikels in dem Markt. Bsp.: Artikel enthält 2,5 Liter, Preis wird für 1 Liter berechnet.'),
preis_vk_brutto_stk
OPTIONS(description='Regulärer Verkaufspreis des Artikels pro Stück. Besteht der Artikel nur aus einem Stück entspricht dies dem preis_vk_brutto. Bspw. Preis einer einzelnen Flasche bei einer Kiste.'),
preis_vk_brutto_aktion_stk
OPTIONS(description='Angebotspreis des Artikels pro Stück. Besteht der Artikel nur aus einem Stück entspricht dies dem preis_vk_brutto_aktion. Bspw. Preis einer Flasche in einer Kiste.'),
proz_preisnachlass
OPTIONS(description='Preisnachlass des Angebotspreises im Vergleich zum regulären Verkaufspreises in Prozent.'),
menge_prog_scm
OPTIONS(description='Prognostizierte Werbemengen von SCM (Supply Chain Management) die benötigt werden und beim Lieferanten bestellt werden sollen.'),
menge_prog_am
OPTIONS(description='Prognostiziertes Ziel der Absatzmenge von AM (Aktionsmanagement) durch Controlling vorgegeben.'),
betrag_prog_rohertrag_scm
OPTIONS(description='Prognostizierter Rohertrag, der sich aus der SCM (Supply Chain Management) Prognose ergibt.'),
betrag_prog_pv OPTIONS(description='Prognostizierter Wert der Preisveränderung (PV).'), betrag_prog_umsatz_am
OPTIONS(description='Prognostiziertes Umsatzziel von AM (Aktionsmanagemen), durch Controlling vorgegeben.'),
betrag_prog_umsatz_scm OPTIONS(description='Prognostiziertes Umsatzziel von SCM (Supply Chain Management)'),
preis_ek_nettonetto OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto.'), proz_art_rabatt
OPTIONS(description='Zusätzlich verhandelter Rabatt mit den Lieferanten in Prozent aus PMR. ZAR5'), preis_ek_mep_vor_fwu
OPTIONS(description='Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt.'),
preis_ek_nettonetto_rabatt
OPTIONS(description='Mit dem verhandelten Rabatt neu berechneter EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto.'),
preis_ek_mep_vor_fwu_rabatt
OPTIONS(description='Mit dem Rabatt neu berechneter Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO wurde als Vergleichswert der EK3Netto ohne (vor) der Festwertumlage eingeführt.'),
proz_prog_spanne_ek_nettonetto
OPTIONS(description='Mit EK netto netto berechnete prognostizierte Spanne (Rohertrag / Kassenumsatz) in Prozent.'),
proz_prog_spanne_ek_mep_vor_fwu
OPTIONS(description='Mit EK MEP vor FWU berechnete prognostizierte Spanne (Rohertrag / Kassenumsatz) in Prozent.'),
proz_prog_spanne_ek_einstandspreis
OPTIONS(description='Mit EK einstandspreis berechnete prognostizierte Spanne (Rohertrag / Kassenumsatz) in Prozent.'),
ek_preis_ermittlung_rabatt_typ_id
OPTIONS(description='Ziel Rabatt Typ aus PMR für ZAR5 Prozess. Sagt aus, welcher Rabatttyp bei der Ermittlung der Einkaufspreise für den angebotenen Artikel verwendet werden soll. 1 = Target EK Preism 2 = Target ZAR5'))
OPTIONS(DESCRIPTION = `Tabellle enthält Daten, wenn Angebote für Artikel in den Märkten verwendet werden.`) AS SELECT
 mandant_id,
 angebot_nr,
 art_id,
 wup_id,
 nb_id,
 verkaufsorganisation_id,
 art_basismenge_einh_id,
 art_typ_cd,
 art_gtin_id,
 mutter_wb_id,
 art_posten_fg,
 art_prio_nr,
 art_theken_verkauf_fg,
 art_nis_fg,
 art_national_fg,
 art_export_werbemittel_fg,
 art_preisangabe_cd,
 art_werbe_prod_gruppe_name,
 gp_id,
 opv_markt_fg,
 opv_prospekt_fg,
 anz_bonuskauf_bezahlt,
 anz_bonuskauf_kauf,
 anz_bonuskauf_gratis,
 proz_bonuskauf_rabatt,
 betrag_bonuskauf_rabatt,
 betrag_bonuskauf_min,
 menge_bonuskauf_min,
 bonuskauf_bedingung_id,
 bonuskauf_dimension_id,
 bonuskauf_produktvariante_id,
 bonuskauf_rabattzuordnung_id,
 wrg_id,
 rabatt_typ_id,
 preis_vk_brutto,
 preis_vk_brutto_aktion,
 preis_vk_brutto_normalisiert,
 preis_vk_brutto_stk,
 preis_vk_brutto_aktion_stk,
 proz_preisnachlass,
 menge_prog_scm,
 menge_prog_am,
 betrag_prog_rohertrag_scm,
 betrag_prog_pv,
 betrag_prog_umsatz_am,
 betrag_prog_umsatz_scm,
 preis_ek_nettonetto,
 proz_art_rabatt,
 preis_ek_mep_vor_fwu,
 preis_ek_nettonetto_rabatt,
 preis_ek_mep_vor_fwu_rabatt,
 proz_prog_spanne_ek_nettonetto,
 proz_prog_spanne_ek_mep_vor_fwu,
 proz_prog_spanne_ek_einstandspreis,
 ek_preis_ermittlung_rabatt_typ_id
FROM kfl_production_dbp_data.angebot_art_wup_zu;