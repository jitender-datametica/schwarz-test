--==============================================================
-- Table: belos_vorgang_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_vorgang_1
   generated from Powerdesigner on Friday, August 5, 2022 5:13:19 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_vorgang_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
belos_vorgang_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierte eindeutige ID für die Belos Vorgänge. Ein Belos Vorgang setzt sich aus einem Transportauftrag_1 (Logistikdaten) und einer Sendung (Abrechnungsdaten).'),
komplettlieferung_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Flag kennzeichnet ob der Belos Vorgang komplett geliefert wurde'),
loesch_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Flag kennzeichnet den Belos Vorgang als geloescht (1 = geloescht)'),
in_time_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen ob alle zu diesem Belos Vorgang gehörigen Positionen fristgerecht geliefert wurden'),
av_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen ob mindestens eine_1 zu diesem Belos Vorgang gehörige Position annahmeverweitert wurde'),
sammel_ladung_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen ob es sich bei der Ladung um einen Sammeltransport oder einen direkten Transport handelt (Sammelladung = 1)'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
sendung_gew_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Gewichtseinheit, z.Bsp. KG'),
sendung_vol_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Volumeneinheit, z.Bsp. CDM'),
dat_leistung DATE NOT NULL OPTIONS(description='Datum der Leistungserstellung - Erstelldatum des Transportauftrags'),
dat_zustellung DATE NOT NULL OPTIONS(description='avisiertes Lieferdatum'),
sendung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fachschlüssel der referenzierten Belos Sendung die diesem Vorgang zugeodnet ist'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort '),
gp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID). Hier der Hauptlieferant (Kreditor_1)'),
gewicht_sendung NUMERIC(9,3) NOT NULL OPTIONS(description='Abrechnungsrelevantes Gewicht der Sendung;'),
zustellart_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen fuer die Arten der Zustellung eines Belos Vorgangs (z. B. Kosten und Fracht, frei Haus verzollt)'),
belos_vorgangart_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen für die Art_1 des Belos Vorgangs (z. B. Beschaffung, Annahmeverweigerung)'),
transportauftrag_id STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Fachschluessel des referenzierten BELOS Transportauftrags der diesem Vorgang zugeodnet ist.'),
sonderabwicklung_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen für die Sonderabwicklung eines Belos Vorgangs (z. B. Gekühlt, Tiko) - Feld enthält Bezeichnung! Compress (\'GK\',\'UGK\')'),
belos_adresse_absender_num_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='numerischer Wert für die belos_adresse. Bei Märkten/Lägern ist hier die wup_id hinterlegt, ansonsten ein negativer Wert. Wird für CROSS JOIN-Zwecke benötigt'),
belos_adresse_abholung_id STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schlüssel zur Identifikation einer Belos Adresse'),
belos_adresse_empfaenger_id STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schlüssel zur Identifikation einer Belos Adresse'),
belos_adresse_spedition_id STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schlüssel zur Identifikation einer Belos Adresse'),
vol_stauraum NUMERIC(18,3) NOT NULL
OPTIONS(description='Abrechnungsrelevantes Volumen des erforderlichen Stauraums der Sendung'),
debitor_id INTEGER NOT NULL OPTIONS(description='Debintorennummer des Absenders /Empfängers.'),
anz_unterverpackung NUMERIC(9,3) OPTIONS(description='Anzahl der Unterverpackungen'),
unterverpackung_menge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Mengeneinheit der Unterverpackung'),
lagernummer_id STRING(4) COLLATE 'und:ci' OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
tour_id INTEGER OPTIONS(description='Nummer des Transportes (Tour_1)'),
belosart_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zeigt an, ob es sich bei dem Vorgang um einen Distributions- oder Beschaffungsvorgang handelt'),
leergut_abh_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag für Leergutabholung'),
retouren_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Retouren Flag'),
industrie_abh_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Industrie Abholung Flag'),
anz_stellplatz NUMERIC(9,2) OPTIONS(description='Anzahl der Stellplätze aus SAP'),
anz_kolli NUMERIC(9,2) OPTIONS(description='Anzahl der Kollis'),
belos_sendungsstatus_id BIGNUMERIC(38,0) DEFAULT 3 NOT NULL
OPTIONS(description='referenziert auf die Lookup-Tabelle l_belos_tourstatus_1! Es werden nur die Ausprägungen 2 und 3 benutzt'),
rundlauf_transport_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='gesetzt bei Touren, die mehr als ein Ziel anfahren. Redundant zu tour_1, muss hier gespeichert werden, da belos_vorgang_1-Daten zeitlich vor tour_1-Daten geliefert werden.'),
fleischwerk_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='zeigt an, ob innerhalb der Tour_1 ein Fleischwerk beliefert wurde. Redundant zu tour_1, muss hier gespeichert werden, da belos_vorgang_1-Daten zeitlich vor tour_1-Daten geliefert werden.'),
distribution_abr_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='zeigt einen abrechnungsrelevanten Vorgang an. Redundant zu tour_1, muss hier gespeichert werden, da belos_vorgang_1-Daten zeitlich vor tour_1-Daten geliefert werden.'),
brtgew_sendung NUMERIC(18,3) OPTIONS(description='Abrechnungsrelevantes Brutto-Gewicht der Sendung;'),
brtvol_stauraum NUMERIC(18,3) NOT NULL
OPTIONS(description='Abrechnungsrelevantes Brutto-Volumen des erforderlichen Stauraums der Sendung'),
anz_stellplatz_belos NUMERIC(9,2) OPTIONS(description='Anzahl der Stellplätze aus dem Belos-System'),
k_na_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag steht für Kaufland-nur Abrechnung. Für Transportprozesse, die in Regie des Dienstleisters durchgeführt werden. Flag wird gesetzt, wenn das Referenzfeld der SST mit CU beginnt'),
belos_auftrag_id_extern STRING(40) COLLATE 'und:ci'
OPTIONS(description='Nur für k_na-Prozesse: Auftragsnummer Warenlieferant aus der Quelle Referenz1 (Beginnt in der Quelle mit CU%)'),
belos_lieferschein_id STRING(40) COLLATE 'und:ci'
OPTIONS(description='Nur für k_na-Prozesse Lieferscheinnummer aus deem Quellfeld Referenz2. '),
belos_sendung_id_extern STRING(40) COLLATE 'und:ci'
OPTIONS(description='Nur für k_na-Prozesse: Sendungsnummer Dienstleister aus dem Quellfeld Referenz4. Beginnt im Quellfeld mit SU%'),
belos_bestell_beleg_id_extern STRING(40) COLLATE 'und:ci'
OPTIONS(description='Nur für k_na-Prozesse: Bestellbelegnummerr aus dem Quellfeld Referenz3. Beginnt im Quellfeld mit PO%'),
referenz STRING(255) COLLATE 'und:ci'
OPTIONS(description='Sonstige Eingaben Feld Referenznummer (enthält Referenz aus SST nde_sendung ohne PO (ab Oktober 2018 befüllt, davor null) - beschränkt auf 200 Zeichen)'),
mandant_id_debitor BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Mandant_ID zur Eindeutigkeit des Debitors (bisher nur DE =1 / 04.06.2016)'),
datzeit_sendung_offen TIMESTAMP OPTIONS(description='Zeitpunkt "Sendung offen"'),
datzeit_ware_versandbereit TIMESTAMP OPTIONS(description='Zeitpunkt "Ware versandbereit"'),
datzeit_sendung_beauftragt TIMESTAMP OPTIONS(description='Zeitpunkt "Sendung beauftragt"'),
datzeit_system_zugestellt TIMESTAMP OPTIONS(description='Zeitpunkt "Systemstatus zugestellt"'),
datzeit_abholung_bis TIMESTAMP OPTIONS(description='Zeitpunkt "Abholtermin (bis)".'),
datzeit_zustellung_bis TIMESTAMP OPTIONS(description='Zeitpunkt "Zustelltermin (bis)".'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, belos_vorgang_id) NOT ENFORCED
)
OPTIONS(description='LIS - Der Belos Vorgang setzt sich aus dem Transportauftrag_1 (mit den Logistikdaten) und den Sendungsinformationen (mit den Abrechnungsdaten) zusammen.');