--==============================================================
-- Table: transportation_unit_kosten_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_kosten_2
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:34:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT_KOSTEN_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum ( (hier: nur Speditionen))',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   transportation_unit_id              INTEGER     NOT NULL COMMENT 'Transporteinheit (intern)',
   kj_transportation_unit              INTEGER     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   betrag_diesel                       NUMBER(29,3)     COMMENT 'zusätzliche Kosten für Diesel',
   betrag_strom                        NUMBER(29,3)     COMMENT 'zusätzliche Kosten für Strom',
   betrag_gas                          NUMBER(29,3)     COMMENT 'zusätzliche Kosten für Gas',
   betrag_maut                         NUMBER(29,3)     COMMENT 'zusätzliche Kosten für Maut',
   betrag_kuehlung                     NUMBER(29,3)     COMMENT 'zusätzliche Kosten für Kühlung',
   betrag_sonstiges                    NUMBER(29,3)     COMMENT 'zusätzliche Kosten weitere',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT_KOSTEN PRIMARY KEY (mandant_id, wup_id, nb_id, transportation_unit_id, kj_transportation_unit) NOT ENFORCED
)  COMMENT = 'Table for additional costs per transportation unit_2 that are not included in WANKO billing data - main source is excel files, manually uploaded in Sharepoint';
