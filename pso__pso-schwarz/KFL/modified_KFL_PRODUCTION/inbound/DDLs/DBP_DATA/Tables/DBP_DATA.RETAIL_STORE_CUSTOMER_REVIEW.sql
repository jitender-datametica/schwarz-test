--==============================================================
-- Table: retail_store_customer_review
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: retail_store_customer_review
   generated from Powerdesigner on Freitag, 20. Juni 2025 15:43:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RETAIL_STORE_CUSTOMER_REVIEW (
   ext_system_name                     VARCHAR(50)      NOT NULL COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42',
   ext_customer_review_id              VARCHAR(100)     NOT NULL COMMENT 'ID der Review im externen System',
   ext_retail_company_id               INTEGER     NOT NULL COMMENT 'Id of the retail company in the system that provides the info',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   ext_store_id                        INTEGER     NOT NULL COMMENT 'Id of the retail store in the system that provides the info',
   review_tmsp                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel, wann der Kunde die Rezension abgegeben hat',
   review_rating                       NUMBER(29,5)     NOT NULL COMMENT 'Bewertung, die der Kunde dem Einzelhandelsgeschäft gegeben hat',
   review_native_txt                   VARCHAR(10000)   COMMENT 'Rezension in der Originalsprache, die der Kunde dem Einzelhandelsgeschäft gegeben hat',
   review_english_txt                  VARCHAR(10000)   COMMENT 'Englische Übersetzung der Rezension, die der Kunde dem Einzelhandelsgeschäft gegeben hat. Diese Spalte ist null, wenn review_native_ext Emoji enthält.',
   review_status_cd                    VARCHAR(1)       COMMENT 'Der Code gibt die Art der Einfügung an, ob die Kundenrezension zuletzt eingefügt oder aktualisiert wurde. (I = Insert, U = Update)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RETAIL_STORE_CUSTOMER_REVIEW PRIMARY KEY (ext_system_name, ext_customer_review_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält 1 Zeile pro Kundenrezension für einen Markt (kann ein KFL-Markt oder ein Konkurrenzmarkt sein). (Stand 09.02.2024) Tabelle enthält nur Google-Bewertungen.';
