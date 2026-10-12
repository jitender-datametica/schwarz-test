--==============================================================
-- Table: retail_store_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: retail_store_2
   generated from Powerdesigner on Freitag, 21. Februar 2025 12:34:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RETAIL_STORE_2 (
   ext_system_name                     VARCHAR(50)      NOT NULL COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
   ext_store_id                        INTEGER     NOT NULL COMMENT 'ID der Filiale im externen System.',
   retail_store_name                   VARCHAR(255)     NOT NULL COMMENT 'Name der Filiale.',
   retail_store_address                VARCHAR(255)     NOT NULL COMMENT 'Adresse der Filiale.',
   breitengrad                         NUMBER(38,16)    NOT NULL COMMENT 'Breitengrad aus dem GIS-System (Latitude)',
   laengengrad                         NUMBER(38,16)    NOT NULL COMMENT 'Laengengrad aus dem GIS-System (Longitude)',
   ext_retail_company_id               INTEGER     NOT NULL COMMENT 'Fremdschlüssel zu retail_company_2, der angibt, zu welchem Markt das Geschäft gehört.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   competitor_wup_id                   VARCHAR(50)      NOT NULL COMMENT 'Von Kaufland intern generierte ID für die Filiale des Mitbewerbers.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RETAIL_STORE PRIMARY KEY (ext_system_name, ext_store_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält 1 Zeile pro Filiale eines Marktes. Einschließlich Kaufland-Filialen und Filialen von Wettbewerbern.';
