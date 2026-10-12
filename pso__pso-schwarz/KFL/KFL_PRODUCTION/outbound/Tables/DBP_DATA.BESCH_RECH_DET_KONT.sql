--==============================================================
-- Table: besch_rech_det_kont
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_rech_det_kont
   generated from Powerdesigner on Mittwoch, 10. August 2022 13:57:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_rech_det_kont (
rech_beleg_id INTEGER NOT NULL
OPTIONS(description='Eindeutige, fortlaufende Belegnummer der Eingangsrechnungen. Zusammen mit dem Geschaeftsjahr kann eine Rechnung eindeutig identifiziert werden.'),
rech_beleg_kont_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fortlaufende Positionnummer pro Eingangsrechnung. Die Positionsnummer ist mit der Rehnungsnummer und dem Geschaeftsjahr in dieser Tabelle eindeutig.'),
gj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschaeftsjahr, dem die Eingangsrechnung zugeordnet ist. Zusammen mit der Belegnummer kann eine Rechnung eindeutig identifiziert werden.'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
kontierungsblock_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Kontierungsblocks.'),
row_grund_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger Fachschluessel fuer die ROW Gruende (Rechnung ohne Wareneingang).'),
dat_row DATE OPTIONS(description='Datum der Rechnugsposition ohne Wareneingang.'),
menge NUMERIC(18,3) OPTIONS(description='Anzahl der Einheiten dieser Position.'),
basismenge_einh_id STRING(3)
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant und Artikel eine alternative Mengeneinheit eindeutig identifiziert.'),
sap_mwst_id STRING(2) OPTIONS(description='Schluessel der Mehrwertsteuer. Referenz zu der Tabelle mwst_per.'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
betrag_beleg NUMERIC(18,4) OPTIONS(description='Netto Betrag der Position aus wrbtr.'),
dat_bezug DATE OPTIONS(description='Bezugsdatum dieser Position;'),
buch_grund_int_id STRING(3)
OPTIONS(description='Eindeutiger Schluessel fuer die internen Buchungsgruende der Rechnungen auf Kopf- und Positionsebene.'),
buch_grund_ext_id STRING(3)
OPTIONS(description='Eindeutiger Schluessel fuer die externe Buchungsgruende der Rechnungen auf Kopf- und Positionsebene.'),
menge_gp_best NUMERIC(18,3) OPTIONS(description='Menge nach Angabe des Lieferanten (aus Rechnung)'),
betrag_gp_best NUMERIC(18,4) OPTIONS(description='Betrag nach Angabe des Lieferanten (aus Rechnung) aus  zzrpbwwr_co.'),
gp_fehlerart_id STRING(1)
OPTIONS(description='Eindeutiger Schluessel für die Fehlerarten eines Lieferanten z. B. Preis- oder Konditionsfehler.'),
korrekturart_id STRING(1)
OPTIONS(description='Eindeutiger Fachschluessel für Korrekturarten bei Mengen- oder Konditionsfehler eines Lieferanten.'),
betrag_gp_fehler_netto NUMERIC(18,2) OPTIONS(description='Nettobetrag des Lieferantenfehlers.'),
rech_kontoart_id STRING(1)
OPTIONS(description='Eindeutiger Fachschluessel für die Kontoart der Rechnungspositionen ohne Bezug zu einer Bestellung.'),
sperrgrund_betrag_fg BIGNUMERIC(38,0)
OPTIONS(description='Dieses Flag kennzeichnet, dass der Sperrgrund aus der Betragshoehe resultiert. 1 = ja, 0 = nein'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
betrag_netto NUMERIC(18,4)
OPTIONS(description='Nettopreis, der sich aus dem Nettowert dividiert durch die Auftragsmenge ergibt.Der Nettopreis bezieht sich immer auf die Konditionsmengeneinheit und die Konditionspreiseinheit der betreffenden Kondition aus zzrpnetpr.'),
retourenpos_fg BIGNUMERIC(38,0) OPTIONS(description='Das Flag gibt an, ob die Position eine Retourenposition ist. '),
wg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0)
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
sachkonto_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Nummer des Sachkontos aus der Spalte saknr. Zur Zeit kene Referenz auf eine Stammtabelle'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rech_beleg_id, rech_beleg_kont_pos_id, gj, system_id, mandant_id, kontierungsblock_nr) NOT ENFORCED
)
OPTIONS(description='RPW - Faktentabelle der Postionen der Eingangsrechnung ohne Bezug zu einer Bestellung (z. B. ungeplante Bezugskosten). Quelle fuer diese Daten ist die SAP Tabelle RBCO.');