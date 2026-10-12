--==============================================================
-- Table: ods_bon_kassen_informationen_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_kassen_informationen_2
   generated from Powerdesigner on Donnerstag, 27. Januar 2022 14:47:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_KASSEN_INFORMATIONEN_2 (
   bon_id                              VARCHAR(25)     NOT NULL COMMENT 'DWH eindeutige ID. Genereirt aus Quellfelder und Hash Wert',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   bon_dat                             DATE            NOT NULL COMMENT 'Das Datum an dem der Bon erstellt wurde',
   kasse_name                          VARCHAR(20)     NOT NULL COMMENT 'Kassennamen. Z.B. DE5190POS14. Land_2 DE, Markt 5190, Typ POS, Kassennr. 14',
   kassen_untertyp                     VARCHAR(30)     DEFAULT 'default' NOT NULL COMMENT 'deviceSubtype (ITAB und NCR sind die beiden verschiedenen SCO Hersteller)',
   bargeld_abwicklung                  VARCHAR(30)     DEFAULT 'none' NOT NULL COMMENT 'Cashrecycler = Glory Münz- und Scheinautomat, Cashdrawer = normale Geldschublade an den Kassen, None = weder noch ',
   umsatz_brutto                       NUMBER(18,4)    COMMENT 'Umsatz brutto. In Landeswaehrung',
   bonanzahl                           NUMBER(38,0)    COMMENT 'Anzahl Bons',
   waage_aktiv_fg                      NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Scale Active. True oder False. Feld sagt aus, ob eine_2 Waage aktiv (1) ist oder nicht (0)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Informationen, welche Kassen es im Markt gibt';
