--==============================================================
-- Table: l_sok_kategorie
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_sok_kategorie
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 11:49:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_SOK_KATEGORIE (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   sok_kategorie_id                    NUMBER(38,0)     NOT NULL COMMENT 'ID der SOK Kategorie. Fasst mehrere primäre Platzierungswarengruppen zu einer übergeordneten Berichtshierarchie-Ebene zusammen.',
   sok_fima_baustein_id                NUMBER(38,0)     NOT NULL COMMENT '"ID des SOK FIMA Baustein - im DWH generierter numerischer Schlüssel. Fasst mehrere SOK Kategorien zu einer übergeordneten Hierarchie-Ebene zusammen."',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_SOK_KATEGORIE PRIMARY KEY (mandant_id, sok_kategorie_id) NOT ENFORCED
)  COMMENT = 'Ebene der SOK Berichtsstruktur. Die SOK Kategorie fasst mehrere primäre Platzierungswarengruppe zu einer übergeordneten Hierarchie-Ebene zusammen. Wird manuell in VIS SOK gepflegt.';
