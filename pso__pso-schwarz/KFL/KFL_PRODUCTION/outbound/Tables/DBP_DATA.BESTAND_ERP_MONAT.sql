CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bestand_erp_monat (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
gjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresmonat'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort'),
menge_lgbest_erp_frei_bme NUMERIC(18,3) OPTIONS(description='Bewerteter, frei verwendbarer Bestand'),
menge_lgbest_erp_umlag_bme NUMERIC(18,3)
OPTIONS(description='Umlagerungsbestand (von Lagerort zu Lagerort): Menge, die aus dem abgebenden Lagerort bereits entnommen wurde, aber in dem empfangenden Lagerort noch nicht eingetroffen ist.            Dieser Umlagerungsbestand enthält die Menge, die aufgrund von Umbuchungen in der'),
menge_lgbest_erp_qual_bme NUMERIC(18,3)
OPTIONS(description='Qualitätsprüfbestand: Menge, die sich in der Qualitätsprüfung befindet. Sie ist Teilmenge des gesamten bewerteten Bestands und ist nicht frei verwendbar. Je nach Einstellung im Customizing gilt der Qualitätsprüfbestand bei der Verfügbarkeitsprüfung der Be'),
menge_lgbest_erp_nf_charge_bme NUMERIC(18,3)
OPTIONS(description='Gesamtbestand aller nicht freien Chargen: Dieser Bestand wird nur bei chargenpflichtigem Material angezeigt, und nur dann, wenn Sie den Bestand im Chargenstammsatz über den Zustandsschlüssel als nicht frei gekennzeichnet haben. Bei der Disposition gilt di'),
menge_lgbest_erp_gesp_bme NUMERIC(18,3) OPTIONS(description='Gesperrter Bestand'),
menge_lgbest_erp_ret_gesp_bme NUMERIC(18,3)
OPTIONS(description='Retourensperrbestand: Menge, die vom Kunden zurückgeschickt und unter Vorbehalt angenommen wurde.            Da Retouren vom Kunden in der Regel noch untersucht werden müssen, wird die zurückgelieferte Menge zunächst in den Retourensperrbestand gebucht. Dieser ist '),
gjmo_bis BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei Lücken in den Monaten zu vereinfachen'),
mard_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='kenneichnet die Quelltabelle des Satzes. Wenn aus mard dann = 1, mardh = 0'),
datzeit_daten_abzug DATETIME OPTIONS(description='Zeitpunkt des Abzugs aus SAP. Wird zu Abgleichszwecken benötigt.'),
vk_brutto NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Der Verkaufspreis (bei auf den Monat bezogenen Daten zum Monatsletzten) wird aus art_wup_zu_per angereichert '),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, gjmo) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='TP2_AIS - Artikelbestand pro WUP und Monat aus den SAP-Tabellen MARD und  MARDH - MULTISET');