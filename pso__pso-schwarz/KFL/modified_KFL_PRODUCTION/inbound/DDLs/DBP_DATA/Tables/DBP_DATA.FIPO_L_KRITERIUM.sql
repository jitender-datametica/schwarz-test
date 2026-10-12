--==============================================================
-- Table: fipo_l_kriterium
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_kriterium
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_KRITERIUM (
   fipo_kriterium_id                   INTEGER     NOT NULL COMMENT 'FIPO - Eindeutige ID eines FIPO Kriteriums aus der Quelltabelle kriterien',
   fipo_kriterium_typ                  VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Kriterientyp  - Jedes Kriterium in K-VISIT wird einem Kriterientyp zugeordnet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_KRITERIUM PRIMARY KEY (fipo_kriterium_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookuptabelle der FIPO-Kriterien';

