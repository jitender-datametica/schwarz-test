--==============================================================
-- Table: fipo_l_kriterium_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_kriterium_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_KRITERIUM_2 (
   fipo_kriterium_id                   NUMBER(38,0)     NOT NULL COMMENT 'FIPO - Eindeutige ID eines FIPO Kriteriums aus der Quelltabelle kriterien',
   fipo_kriterium_typ                  VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Kriterientyp  - Jedes Kriterium in K-VISIT wird einem Kriterientyp zugeordnet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_KRITERIUM PRIMARY KEY (fipo_kriterium_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookuptabelle der FIPO-Kriterien';

