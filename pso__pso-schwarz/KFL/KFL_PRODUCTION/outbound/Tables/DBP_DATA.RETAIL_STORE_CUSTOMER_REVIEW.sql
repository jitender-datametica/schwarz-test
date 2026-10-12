--==============================================================
-- Table: retail_store_customer_review
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: retail_store_customer_review
   generated from Powerdesigner on Freitag, 20. Juni 2025 15:43:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.retail_store_customer_review (
ext_system_name STRING(50) NOT NULL
OPTIONS(description='Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42'),
ext_customer_review_id STRING(100) NOT NULL OPTIONS(description='ID der Review im externen System'),
ext_retail_company_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the retail company in the system that provides the info'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ext_store_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the retail store in the system that provides the info'),
review_tmsp DATETIME NOT NULL OPTIONS(description='Zeitstempel, wann der Kunde die Rezension abgegeben hat'),
review_rating BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Bewertung, die der Kunde dem Einzelhandelsgeschäft gegeben hat'),
review_native_txt STRING(10000)
OPTIONS(description='Rezension in der Originalsprache, die der Kunde dem Einzelhandelsgeschäft gegeben hat'),
review_english_txt STRING(10000)
OPTIONS(description='Englische Übersetzung der Rezension, die der Kunde dem Einzelhandelsgeschäft gegeben hat. Diese Spalte ist null, wenn review_native_ext Emoji enthält.'),
review_status_cd STRING(1)
OPTIONS(description='Der Code gibt die Art der Einfügung an, ob die Kundenrezension zuletzt eingefügt oder aktualisiert wurde. (I = Insert, U = Update)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ext_system_name, ext_customer_review_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält 1 Zeile pro Kundenrezension für einen Markt (kann ein KFL-Markt oder ein Konkurrenzmarkt sein). (Stand 09.02.2024) Tabelle enthält nur Google-Bewertungen.');