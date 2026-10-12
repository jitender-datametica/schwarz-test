--==============================================================
-- Table: ivs_plan_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ivs_plan_2
   generated from Powerdesigner on Freitag, 21. Oktober 2022 08:38:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IVS_PLAN_2 (
   plandetail_id                       INTEGER    NOT NULL COMMENT 'Eindeutige ID fuer ein Plandetail',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2',
   plantyp_id                          INTEGER    NOT NULL COMMENT 'Eindeutige ID des Plantyps',
   plan_objekt_id                      VARCHAR(50)     NOT NULL COMMENT 'ID, auf der geplant wird. Kann zb. eine_2 Kostenstelle aus TP4 oder Flaeche aus TP5 sein.',
   kjmo                                INTEGER    NOT NULL COMMENT 'Kalenderjahr und Monat_2',
   plan_wert                           NUMBER(29,2)    COMMENT 'Geplanter Wert in Landeswährung',
   plan_wert_konz                      NUMBER(29,2)    COMMENT 'Geplanter Wert in Konzernwährung',
   kostenstelle_id                     VARCHAR(20)     NOT NULL COMMENT 'Eindeutige ID der Kostenstelle (aus SAP, Paisy-Kostenstellen werden auf SAP-Kostenstellen gemappt, bzw. fuer einige Faelle die Hyperion-Kostenstelle)',
   dat_extrakt                         DATE            NOT NULL COMMENT 'Extraktions- bzw. Erstellungsdatum des Datensatzes',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IVS_PLAN PRIMARY KEY (plantyp_id, plandetail_id, mandant_id, plan_objekt_id) NOT ENFORCED
)  COMMENT = 'IVS - Plandaten Köpfe, Kosten, Stunden_2';
