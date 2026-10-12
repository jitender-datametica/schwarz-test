--==============================================================
-- Table: eps_containertyp_anstossherkunft_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_containertyp_anstossherkunft_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_CONTAINERTYP_ANSTOSSHERKUNFT_ZU (
   mandant_id                          INTEGER     NOT NULL,
   containertyp_id                     INTEGER     NOT NULL COMMENT 'ID des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)',
   anstossherkunft_kz                  VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Kennzeichen - Bezeichnung der Anstoßherkunft (z.B. m = dezentral, z = zentral)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_CONTAINERTYP_ANSTOSSHERKUNFT_ZU PRIMARY KEY (mandant_id, containertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Lookuptabelle für die Bezeichnung der Containertypen (Druckgrund ) aus EPS (z.B. aus MDE, Änderungsdienst, Nachdruck,….) - manuelle Beladung';

