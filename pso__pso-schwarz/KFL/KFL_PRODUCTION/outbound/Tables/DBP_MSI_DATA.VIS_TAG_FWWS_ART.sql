CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_tag_fwws_art (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH, ein Mandant je Land '),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb. 0 = Markt'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, PrÃ¼fziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
dispomerkmal STRING(2) NOT NULL
OPTIONS(description='Schluessel, der bestimmt, ob und wie das Material disponiert wird, z.Bsp. manuelle Bestellpunktdisposition aus dismm'),
disponent_id STRING(3) NOT NULL OPTIONS(description='Disponent ID'),
artikel_exc209_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ermittlung der Artikel mit Ausnahmegrund = 209'),
artikel_exc214_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ermittlung der Artikel mit Ausnahmegrund = 214'),
tagesartikel_fg BIGNUMERIC(38,0) OPTIONS(description='Ermittlung der Tagesartikel'),
bestandsartikel_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ermittlung der Bestandsartikel '),
autodispo_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ermittlung fer Artikel Autodispo '),
alle_art_o_kdis_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ermittlung der Artikel mit kdis = 0 und listung_id = 1'),
alle_art_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ermittlung der Artikel mit listung_id = 1'),
autodispo_fg_12 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ermittlung der Artikel Autodispo mit dm = 12 '),
bezugsweg_id BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY mandant_id, dat
OPTIONS(description='VIS - Aggregat FWWS auf Artikel-Tagesebene ');