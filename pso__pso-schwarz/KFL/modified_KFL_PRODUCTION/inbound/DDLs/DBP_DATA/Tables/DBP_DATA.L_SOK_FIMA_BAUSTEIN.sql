--==============================================================
-- Table: l_sok_fima_baustein
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_sok_fima_baustein
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 12:04:01
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_SOK_FIMA_BAUSTEIN (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   sok_fima_baustein_id                INTEGER     NOT NULL COMMENT 'ID des SOK FIMA Baustein - im DWH generierter numerischer Schlüssel. Fasst mehrere SOK Kategorien zu einer übergeordneten Hierarchie-Ebene zusammen.',
   sok_fima_baustein_nr                VARCHAR(10)      COMMENT 'Nummer des SOK FIMA Baustein - nicht-numerischer Schlüssel aus dem Quellsystem. Fasst mehrere SOK Kategorien zu einer übergeordneten Hierarchie-Ebene zusammen.',
   sok_abteilung_id                    INTEGER     COMMENT 'ID der SOK Abteilung. Fasst die SOK Fima Bausteine zu einer übergeordneten Berichtshierarchie-Ebene zusammen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_SOK_FIMA_BAUSTEIN PRIMARY KEY (mandant_id, sok_fima_baustein_id) NOT ENFORCED
)  COMMENT = 'Ebene der SOK Berichtsstruktur. Der SOK FIMA (Filialmaßnahmen) Baustein fasst die SOK Kategorien zu den FIMA Bausteinen seitens Immo in einer übergeordneten Hierarchie Ebene zusammen. Wird manuell in VIS SOK gepflegt.';
