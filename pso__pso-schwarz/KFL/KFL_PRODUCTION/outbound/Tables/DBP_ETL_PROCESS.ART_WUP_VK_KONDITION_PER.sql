CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_wup_vk_kondition_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsorganisation aus vkorg'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs aus vtweg'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
kl_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer.'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='Aus matkl.'),
preisliste_typ_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Preislistentyp, z.Bsp. F0 aus pltyp'),
quelltabelle_name STRING(50) NOT NULL OPTIONS(description='Aus source.'),
konditionsart_id STRING(4) NOT NULL OPTIONS(description='Konditionsart. Aus kschl.'),
datzeit_erstellung_kondition TIMESTAMP
OPTIONS(description='Zeitpunkt, an dem die Kondition angelegt wurde. Kann nicht nach dem Gültigkeitsbeginn liegen.'),
datzeit_kondition_gueltig_von TIMESTAMP NOT NULL
OPTIONS(description='Zeitpunkt Gültigkeitsbeginn des Satzes aus datab und timab'),
datzeit_kondition_gueltig_bis TIMESTAMP
OPTIONS(description='Zeitpunkt Gültigkeitsende des Satzes aus datbi und timbi'),
vk_brutto BIGNUMERIC(38,2) OPTIONS(description='Aus kbetr'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Aus konwa.'),
menge_kondition_gueltig_ab BIGNUMERIC(38,0) OPTIONS(description='Aus kpein.'),
konditionssatz_id BIGNUMERIC(38,0) OPTIONS(description='Nummer der Kondition aus knumh'),
aktion_id STRING(10) OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle waktion'),
datzeit_erstellung_quelle TIMESTAMP
OPTIONS(description='Zeitpunkt, an dem der Datensatz im Quellsystem eingefügt wurde.'),
datzeit_extrakt TIMESTAMP OPTIONS(description='Zeitpunkt der Extraktion aus dem Quellsystem.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, vw_id, wup_id, nb_id, art_id, konditionsart_id, quelltabelle_name,
 datzeit_kondition_gueltig_von) NOT ENFORCED
) OPTIONS(description='SOURCE: ZEK_SP_STORE_VAL');