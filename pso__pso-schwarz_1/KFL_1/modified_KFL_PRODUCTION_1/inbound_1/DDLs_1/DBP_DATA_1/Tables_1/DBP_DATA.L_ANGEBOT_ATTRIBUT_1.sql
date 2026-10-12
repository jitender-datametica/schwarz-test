--==============================================================
-- Table: l_angebot_attribut_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_angebot_attribut_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:31:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ANGEBOT_ATTRIBUT_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   angebot_attribut_id                 INTEGER     NOT NULL COMMENT 'ID des Attributs.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_ANGEBOT_ATTRIBUT PRIMARY KEY (mandant_id, angebot_attribut_id) NOT ENFORCED
)  COMMENT = 'Enthält mögliche Attribute / Charakteristiken die einem Angebot_1 zusätzlich noch hinzugefügt werden können. Diese zusätzlichen Attribute können dabei sehr unterscheidlich sein und beispielsweise Informationen zu den Bestellmengen, Platzierung in der Filiale, Darstellung im Werbemittel, etc. enthalten.';
