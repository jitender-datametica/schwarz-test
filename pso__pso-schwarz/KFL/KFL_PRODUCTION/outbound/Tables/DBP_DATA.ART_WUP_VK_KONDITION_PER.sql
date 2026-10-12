--==============================================================
-- Table: art_wup_vk_kondition_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_vk_kondition_per
   generated from Powerdesigner on Donnerstag, 24. Oktober 2024 18:12:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_vk_kondition_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH, aus MANDT.'),
verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsorganisation, aus VKORG.'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs, aus VTWEG.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum, aus WERKS.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1, transformiert aus MATNR.'),
konditionsart_id STRING(4) NOT NULL OPTIONS(description='Konditionsart, aus KSCHL.'),
datzeit_gueltig_von_kondition TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsbeginn des Preises, aus DATAB und TIMAB.'),
datzeit_gueltig_bis_kondition TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsende des Preises, aus DATBI und TIMBI'),
datzeit_erstellung_kondition TIMESTAMP NOT NULL
OPTIONS(description='Zeitpunkt, an dem diese Preiskondition angelegt wurde, aus ERDAT und ERZET. Ist vor oder gleich dem Gültigkeitsbeginn.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR, aus KONWA.'),
preis_vk_brutto BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Verkaufspreis in brutto, aus KBETR.'),
konditionssatz_id STRING(10) OPTIONS(description='Konditionssatznummer, aus KNUMH.'),
aktion_id STRING(10) OPTIONS(description='Eindeutige Kennung einer Aktion, aus WAKTION.'),
quelltabelle_name STRING(100) NOT NULL
OPTIONS(description='Name der Quelltabelle im SAP System aus dem die Daten in ZEK_SP_STORE_VAL gefüllt wurden, aus SOURCE.            Jede dieser Tabellen entspricht in etwa einem Prozessschritt an dem ein VK-Preis definiert wurde.            A006 - Preislistentyp/Währung/Material            A517 - VKO/VTW/WERK/MAT            ZVKP2 - Markt - Verkaufspreise speziell (z.B. AS-Food)            ZVKP3 - Markt - Verkaufspreise speziell (z.B. AS-Food)'),
datzeit_erstellung_quelle TIMESTAMP NOT NULL
OPTIONS(description='Zeitpunkt, an dem der Datensatz im Quellsystem eingefügt wurde, aus CRDATE und CRTIME.'),
datzeit_extrakt TIMESTAMP NOT NULL
OPTIONS(description='Zeitpunkt der Extraktion aus dem Quellsystem.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, vw_id, wup_id, nb_id, art_id, konditionsart_id, datzeit_gueltig_von_kondition) NOT ENFORCED
)
OPTIONS(description='WWC - This table contains different sales prices for articles and their validity-timeframes. Different sales prices are created and stored because of different processes. More than one sales price can be valid at a time depending on factors such as condition type or sales channel, i.e. KL app users can get an additional discount / lower price at check-out, or package damage resulting in an additional discount.             Source: ZEK_SP_STORE_VAL');