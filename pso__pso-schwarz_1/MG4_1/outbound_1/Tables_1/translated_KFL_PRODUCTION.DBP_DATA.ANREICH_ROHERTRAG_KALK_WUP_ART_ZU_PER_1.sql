DROP TABLE IF EXISTS kfl_production_dbp_data.anreich_rohertrag_kalk_wup_art_zu_per_1;
CREATE OR REPLACE TABLE kfl_production_dbp_data.anreich_rohertrag_kalk_wup_art_zu_per_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
berichtstyp_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Berichtstyp wird für die jahresübergreifende Betrachtung benötigt. Berichtstyp 1: Rohertrag akt. Jahr zum Stichtag; Berichtstyp 4: Rohertrag aus Vorjahr zum Stichtag (Rohertrag = Summe Berichtstyp 1+4)'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
dat_zeitscheibe DATE NOT NULL OPTIONS(description='Datum der (Tages-) Zeitscheibe'),
datzeit_erstellung DATETIME NOT NULL
OPTIONS(description='UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) aus Excel - Zeitpunkt der Erstellung des Datensatz'),
datzeit_upload DATETIME NOT NULL OPTIONS(description='Zeitpunkt des Uploads'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
basismenge_einh_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='ID der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_1 und Artikel_1 eine_1 alternative Mengeneinheit eindeutig identifiziert '),
mep_we_differenz NUMERIC(18,2) DEFAULT 0 OPTIONS(description='MEP / WE-Differenz'),
spannenkorrektur NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Spannenkorrektur'),
finanzbonus NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Finanzbonus'),
jahresbonus NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Jahresbonus'),
steigergungsbonus_de NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Steigergungsbonus (DE)'),
markantbonus_de NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Markantbonus (DE)'),
steigerungs_markantbonus_kmo NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Steigerungs- / Markantbonus (KMO)'),
steigerungs_markantbonus NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Steigerungs- / Markantbonus'),
verbesserungspot_aus_nachm NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Verbesserungspot. aus Nachm.'),
verg_a_d_sp NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Verg. a. d. Sp. (DE: lfd. KJ, KMO: GJ)'),
abgrenzung_verguetungen NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Abgrenzung Vergütungen'),
verguetungen_vorjahre NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Vergütungen Vorjahre'),
apm NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='APM'),
umsatz_export NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Export'),
wareneinsatz_export NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Wareneinsatz Export'),
inventur_diebstahl_ta_geb_vt NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Inventur_1 Diebstahl TA geb. VT'),
ueberleitung_vkn_zu_ek NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Überleitung VKn zu EK'),
bewertungskorrekturen_bestand NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Bewertungskorrekturen Bestand'),
mwst_auf_totalabschr_inv_diff NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='MwSt. auf Totalabschr. / Inv.diff.'),
sondersteuer NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Sondersteuer'),
steuern NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Steuern'),
kursdifferenzen_ware NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Kursdifferenzen Ware'),
wertberichtigung_lieferantenboni NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Kursdifferenzen WareWertberichtigung Lieferantenboni'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, gp_id, dat_zeitscheibe, datzeit_erstellung) NOT ENFORCED
) CLUSTER BY dat_zeitscheibe
OPTIONS(description='REB - Definierte Einzelpositionen - manuelles Excel-Upload - zum Rohertrag (Tabelle rohertrag_kalk_wup_art_zu_per_1)');