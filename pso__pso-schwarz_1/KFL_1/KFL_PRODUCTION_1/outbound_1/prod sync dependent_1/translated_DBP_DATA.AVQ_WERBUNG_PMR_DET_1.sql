CREATE OR REPLACE TABLE kfl_production_dbp_data.avq_werbung_pmr_det_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
dat_aktion_von DATE NOT NULL OPTIONS(description='Werbung/Aktion_1 gültig ab'),
dat_aktion_bis DATE NOT NULL OPTIONS(description='Werbung/Aktion_1 gültig bis'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Nummer des Angebots aus PMR'),
werbemittelkanal_id STRING(4) NOT NULL
OPTIONS(description='Werbemittel Art_1 ID - medium through which the advertisement is shown (paper, digital)'),
werbemittel_id STRING(2) NOT NULL
OPTIONS(description='Werbemittel - on what item_1 the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)'),
werbeflaechenthema_cd STRING(50) NOT NULL OPTIONS(description='Code des Werbeflaechenthemas'),
werbeflaechenabschnitt_id INTEGER NOT NULL OPTIONS(description='ID des Werbeflächenabschnitts'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Eindeutige Kennung einer Aktion_1 aus der Quelle wakh.aktnr'),
dat_sperrung INTEGER OPTIONS(description='Datum, zu dem ein Artikel_1 gesperrt wurde. Aus aktion_art_wup_zu_1'),
dat_preisaktivierung DATE OPTIONS(description='Datum der Aktionspreisaktivierung. Aus aktion_art_wup_zu_1'),
dat_geloescht_sap DATE OPTIONS(description='Datum der Löschung. Aus aktion_art_wup_zu_1'),
kjwo INTEGER
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW. Fuer DE die Woche_1, in der die Werbung endet. Fuer KMO die Woche_1, in der die Werbung beginnt.'),
bby_fg INTEGER OPTIONS(description='Flag: Bonusbuy'),
kdn_fg INTEGER OPTIONS(description='Flag: KDN-Aktion_1 (K-CARD)'),
kdp_fg INTEGER OPTIONS(description='Flag: KDP-Aktion_1 (Kundenindividuell)'),
pmr_top_art_fg INTEGER NOT NULL OPTIONS(description='TOP-Artikel_1 Flag (PMR)'),
werbemittel_avq_prio_nr INTEGER
OPTIONS(description='Für die AVQ können verschiedene Werbemittel zusammengefasst werden, ID gibt die Reihenfolge / Priorisierung vor'),
werbeflaechenabschnitt_avq_prio_nr INTEGER OPTIONS(description='Bezeichnung des Werbeflaechenthemas (AVQ)'),
werbeflaechenthema_avq_prio_nr INTEGER
OPTIONS(description='Für die AVQ können verschiedene Werbeflächenthemen zusammengefasst und/oder priorisiert werden, ID gibt die Reihenfolge vor'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
angebot_typ_cd STRING(10) OPTIONS(description='Alphanumerischer Code des Angebotstyp.'),
aktion_typ_id STRING(4)
OPTIONS(description='Handelt es sich bei dem Angebot_1 um eine_1 Aktion_1 gibt der Typ die Art_1 der Aktion_1 an: KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = Promotion die bei einem externen Partner erworben wurde (bspw.Partner Coupon, SMP Coupon, Gutschein_1 von Partner.'),
geschaeftsvorfall_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Eindeutige ID eines Geschäftsvorfalls aus gv_id, z.Bsp. 01'),
konditionsart_id STRING(4) OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'),
rabatt_typ_id INTEGER
OPTIONS(description='ID des Rabatt Typs. Gibt die Art_1 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'),
anz_bonuskauf_bezahlt INTEGER
OPTIONS(description='Handelt es sich bei dem Angebot_1 um einen Bonuskauf, kann hier die Anzahl der Artikel_1 stehen, die bezahlt werden müssen (Betrifft nicht alle Bonuskauf-Typen).'),
anz_bonuskauf_kauf INTEGER
OPTIONS(description='Handelt es sich bei dem Angebot_1  um einen Bonuskauf, kann hier die Anzahl an Artikeln stehen, die gekauft werden müssen. (Betrifft nicht alle Bonuskauf-Typen)'),
anz_bonuskauf_gratis INTEGER
OPTIONS(description='Handelt es sich bei dem Angebot_1 um einen Bonuskauf, kann hier die Anzahl an Artikeln stehen, die kostenlos erhalten werden. (Betrifft nicht alle Bonuskauf Typen)'),
menge_bonuskauf_min NUMERIC(29,5)
OPTIONS(description='Handelt es sich bei dem Angebot_1 um einen Bonuskauf, kann hier die Mindestmenge (absatzbezogen) stehen, die erreicht werden muss, um die Bedingung für den Bonusbuy zu erfüllen (Betrifft nicht alle Bonuskauf Typen).'),
proz_bonuskauf_rabatt NUMERIC(29,5)
OPTIONS(description='Handelt es sich bei dem Angebot_1 um einen Bonuskauf und der Rabatt ist prozentbezogen, kann hier der Rabatt in Prozent stehen (Betrifft nicht alle Bonuskauf Typen).'),
betrag_bonuskauf_rabatt NUMERIC(29,5)
OPTIONS(description='Handelt es sich bei dem Angebot_1 um einen Bonuskauf und der Rabatt ist absolut, kann hier der Wert des Rabattes stehen (Betrifft nicht alle Bonuskauf Typen).'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_aktion_von, dat_aktion_bis, angebot_nr, werbemittelkanal_id,
 werbemittel_id, werbeflaechenthema_cd, werbeflaechenabschnitt_id) NOT ENFORCED
)
OPTIONS(description='AVQ(Abverkaufsquote) PMR-Details - Zusatzebene, enthält alle relevanten Aktionen sowie Angebote(Offers) im Aktionszeitraum inkl. aller zugeordneter Werbemittel/Flächen/Abschnitte.');