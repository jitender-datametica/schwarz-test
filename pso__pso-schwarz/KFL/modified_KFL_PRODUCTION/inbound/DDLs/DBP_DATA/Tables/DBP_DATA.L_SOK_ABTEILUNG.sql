--==============================================================
-- Table: l_sok_abteilung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_sok_abteilung
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 12:12:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_SOK_ABTEILUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   sok_abteilung_id                    INTEGER     NOT NULL COMMENT 'ID der SOK Abteilung. Fasst die SOK Fima Bausteine zu einer übergeordneten Hierarchie-Ebene zusammen.',
   food_nonfood_kategorie_id           INTEGER     COMMENT 'ID der Food / Non Food Kategorie. ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_SOK_ABTEILUNG PRIMARY KEY (mandant_id, sok_abteilung_id) NOT ENFORCED
)  COMMENT = 'Ebene der SOK Berichtsstruktur. Die SOK Abteilung fasst die SOK FIMA Bausteine zu einer übergeordneten Hierarchie Ebene für die entscheidungsrelevante Bereiche Ultra-Frische, Food und Non-Food zusammen. Wird manuell in VIS SOK gepflegt.';
