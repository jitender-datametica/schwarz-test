--==============================================================
-- Table: l_cpr_suchfeld_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_cpr_suchfeld_1
   generated from Powerdesigner on Dienstag, 27. Juni 2023 17:55:27
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_CPR_SUCHFELD_1 (
   cpr_suchfeld_id                     INTEGER     NOT NULL COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
   cpr_suchfeld                        VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Aus der Quelle geliefertes Suchfeld',
   cpr_suchfeld_akt_fg                 INTEGER     NOT NULL DEFAULT 1COMMENT 'aktiv genutzte Suchfelder',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_CPR_SUCHFELD PRIMARY KEY (cpr_suchfeld_id) NOT ENFORCED
)  COMMENT = 'IOS - Lookuptabelle für das zentrals C-Projects-Suchfeld';