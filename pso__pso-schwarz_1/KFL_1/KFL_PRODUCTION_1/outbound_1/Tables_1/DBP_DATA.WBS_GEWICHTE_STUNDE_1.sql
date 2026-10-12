CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_gewichte_stunde_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion_1 aus der Quelle wakh.aktnr'),
dat_von DATE OPTIONS(description='YYYY-MM_1-DD // Aktion_1 gültig (von)'),
dat_bis DATE OPTIONS(description='YYYY-MM_1-DD // Aktion_1 gültig (bis)'),
anzahl_faelle BIGNUMERIC(38,0) OPTIONS(description='Die Zahl der für die Berechnung verwendeter Fälle.'),
anzahl_faelle_im_korridor BIGNUMERIC(38,0)
OPTIONS(description='Die Zahl der für die Berechnung verwendeter Fälle im Berechnungskorridor.'),
korridor_level BIGNUMERIC(38,0)
OPTIONS(description='Berechnete Werte aus Stundengewichten (WERBEANTEIL_IM_ZEITFENSTER) werden im AdjustmentCore mit einem Korridor (MIN_MENGE & MAX_MENGE) plausibilisert und bei Abweichung korrigiert.'),
kategorie STRING(100)
OPTIONS(description='Kennzeichnung, der Berechnungsgrundlage zu Evaluation:stable == Original Bondatensearch == Angereicherte Datenall == Aggregierte Daten'),
menge_max BIGNUMERIC(38,0) OPTIONS(description='Maximale Korridormenge'),
menge_min BIGNUMERIC(38,0) OPTIONS(description='Minimale Korridormenge'),
menge_avg_21tage BIGNUMERIC(38,4)
OPTIONS(description='Durchschnittsmenge 21 Tage vor der jeweiligen Werbung (Sonntag zu Sonntag).'),
anteil_zeitfenster1 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an IInitialmenge für Zeitfenster 1'),
anteil_zeitfenster2 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an IInitialmenge für Zeitfenster 2'),
referenziert_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag, ob die Berechnungsgrundlage mittels Referenzartikeln stabilisiert wurde.'),
wbs_level STRING(100)
OPTIONS(description='Berechnungsebene der Gewichte:  item_1 country_1:	3 ,wg_wug store: 4,wg store:	5,wg_wug country_1:	6 ,wg country_1:	7 ,default:	8'),
wbs_level_id BIGNUMERIC(38,0) OPTIONS(description='Id der Berechnungsebene der Gewichte'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);