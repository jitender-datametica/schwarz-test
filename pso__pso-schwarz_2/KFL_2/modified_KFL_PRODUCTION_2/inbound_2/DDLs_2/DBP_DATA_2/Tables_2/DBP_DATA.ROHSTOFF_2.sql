--==============================================================
-- Table: rohstoff_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_2
   generated from Powerdesigner on Montag, 22. September 2025 12:38:51
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ROHSTOFF_2 (
   rohstoff_nr                         VARCHAR(20)      NOT NULL COMMENT 'Mintecs Interne ID des Rohstoffs.',
   rohstoff_basis_einh_name            VARCHAR(100)     NOT NULL COMMENT 'Die Basiseinheit des Rohstoffs (native).',
   rohstoff_bez                        VARCHAR(300)     NOT NULL COMMENT 'Bezeichnung des Rohstoffs.',
   rohstoff_kfl_bez                    VARCHAR(300)     NOT NULL COMMENT 'Kaufland interne Bezeichnung des Rohstoffs.',
   rohstoff_beschreibung_txt           VARCHAR(1000)    NOT NULL COMMENT 'Beschreibung des Rohstoffs.',
   rohstoff_qualitaet_txt              VARCHAR(1000)    COMMENT 'Beschreibung der Qualität des Rohstoffs.',
   rohstoff_herkunftsort_name          VARCHAR(100)     COMMENT 'Herkunfsort des Rohstoffs - Dieser kann Land_2, Region_2 oder Länderguppe sein.',
   rohstoff_lieferort_name             VARCHAR(100)     NOT NULL COMMENT 'Land_2, Region_2 oder Ländergruppe, die den Rohstof fliefert.',
   rohstoff_quell_bez                  VARCHAR(200)     COMMENT 'Enthält Informationen zur Quelle des Rohstoffes.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ROHSTOFF PRIMARY KEY (rohstoff_nr) NOT ENFORCED
)  COMMENT = 'Diese Tabelle enthält Informationen über die Rohstoffe verwendet bei Kaufland.';
