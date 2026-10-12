--==============================================================
-- Table: in_wartungsplan_zyklus
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_zyklus
   generated from Powerdesigner on Montag, 20. Februar 2023 09:47:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_WARTUNGSPLAN_ZYKLUS (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   wart_plan_id                        NUMBER(38,0)     NOT NULL COMMENT 'Wartungsplan',
   wart_plan_zaehler                   NUMBER(38,0)     COMMENT 'Zähler (identifier of the plan cycle within the plan context)',
   zyklus_wert_sek                     NUMBER(38,16)    COMMENT 'Zyklus / Offset eines Wartungspaketes (immer in Sekunden!)',
   zyklus_einh_id                      VARCHAR(3)       COMMENT 'Anzeige-Einheit für die Durchführung von Wartungsmaßnahmen',
   zyklus_wert                         NUMBER(38,0)     COMMENT 'Zyklus / Offset eines Wartungspaketes in Anzeige-Einheit gerundet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_WARTUNGSPLAN_ZYKLUS PRIMARY KEY (mandant_id, wart_plan_id) NOT ENFORCED
)  COMMENT = 'Zyklusdefinition Wartungsplan ';
