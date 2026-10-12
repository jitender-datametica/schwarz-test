--==============================================================
-- Table: retail_store_distance_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: retail_store_distance_1
   generated from Powerdesigner on Freitag, 21. Februar 2025 12:34:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RETAIL_STORE_DISTANCE_1 (
   ext_system_name                     VARCHAR(50)      NOT NULL COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
   ext_store_id                        INTEGER     NOT NULL COMMENT 'ID der Filiale im externen System.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   drivetime_distance_km               NUMBER(38,16)    NOT NULL COMMENT 'Entfernung zwischen zwei Filialen (Fahrstrecke in KM).',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RETAIL_STORE_DISTANCE PRIMARY KEY (ext_system_name, ext_store_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält Entfernungen zwischen Filialen. Wird verwendet, um geografisch nahe gelegene Konkurrenten zu identifizieren.';
