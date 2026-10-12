--==============================================================
-- Table: ods_bon_kassen_informationen_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_kassen_informationen_1
   generated from Powerdesigner on Donnerstag, 27. Januar 2022 14:47:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_KASSEN_INFORMATIONEN_1 (
   bon_id                              VARCHAR(25)     NOT NULL COMMENT 'DWH eindeutige ID. Genereirt aus Quellfelder und Hash Wert',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   bon_dat                             DATE            NOT NULL COMMENT 'Das Datum an dem der Bon erstellt wurde',
   kasse_name                          VARCHAR(20)     NOT NULL COMMENT 'Kassennamen. Z.B. DE5190POS14. Land_1 DE, Markt 5190, Typ POS, Kassennr. 14',
   kassen_untertyp                     VARCHAR(30)     DEFAULT 'default' NOT NULL COMMENT 'deviceSubtype (ITAB und NCR sind die beiden verschiedenen SCO Hersteller)',
   bargeld_abwicklung                  VARCHAR(30)     DEFAULT 'none' NOT NULL COMMENT 'Cashrecycler = Glory Münz- und Scheinautomat, Cashdrawer = normale Geldschublade an den Kassen, None = weder noch ',
   umsatz_brutto                       NUMBER(29,4)    COMMENT 'Umsatz brutto. In Landeswaehrung',
   bonanzahl                           INTEGER    COMMENT 'Anzahl Bons',
   waage_aktiv_fg                      INTEGER    DEFAULT 0 NOT NULL COMMENT 'Scale Active. True oder False. Feld sagt aus, ob eine_1 Waage aktiv (1) ist oder nicht (0)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Informationen, welche Kassen es im Markt gibt';
