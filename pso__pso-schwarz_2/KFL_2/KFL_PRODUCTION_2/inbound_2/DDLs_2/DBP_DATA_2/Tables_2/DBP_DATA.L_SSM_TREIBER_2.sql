--==============================================================
-- Table: l_ssm_treiber_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ssm_treiber_2
   generated from Powerdesigner on Montag, 30. Januar 2023 18:38:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_SSM_TREIBER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   treiber_id                          NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID des Sollstunden-Modell-Treiber (Einflussgrößen auf den Personalaufwand /Tätigkeit des Marktmitarbeiter)',
   dat_von                             DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT - Datum ab Gültigkeit',
   dat_bis                             DATE             NOT NULL DEFAULT CAST ('9999-12-31' AS DATE) COMMENT 'Datum im Format JJJJ-MM_2-TT',
   treiber_bez                         VARCHAR(50)      NOT NULL DEFAULT ' ' COMMENT 'Bezeichnung des Sollstunden-Modell-Treiber (Einflussgrößen auf den Personalaufwand /Tätigkeit des Marktmitarbeiter)',
   aufgabe_tages_versatz               NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl des Tagesversatzes, um wie viel der Treiber in die Tabelle ssm_wup_tag_treiber_2 übernommen werden soll.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_SSM_TREIBER PRIMARY KEY (mandant_id, treiber_id) NOT ENFORCED
)  COMMENT = 'VIS - Lookuptabelle für die Treiber (Einflussgrößen auf den Personalaufwand im Markt) im Sollstunden-Modell';
