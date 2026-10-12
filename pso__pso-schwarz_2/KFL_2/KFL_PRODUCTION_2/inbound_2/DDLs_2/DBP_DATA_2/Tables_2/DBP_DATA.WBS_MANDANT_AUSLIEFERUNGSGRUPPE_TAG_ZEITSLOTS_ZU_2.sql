--==============================================================
-- Table: wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu_2
   generated from Powerdesigner on Wednesday, August 24, 2022 12:59:22 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_MANDANT_AUSLIEFERUNGSGRUPPE_TAG_ZEITSLOTS_ZU_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH.',
   auslieferungsgruppe_id              VARCHAR(4)      NOT NULL COMMENT 'ID der Auslieferungsgruppe. Eine_2 Auslieferungsgruppe (manchmal auch Ausliefergruppe) ist eine_2 Buendelung von Artikeln mit gleichen Eigenschaften Aufgrund welchen sie zusammen ausgeliefert werden koennen, VZ in Richtung Filiale. Z.B.: Food Trocken (Mehl, Konserven, Nudeln), Tiefkuehlware (Fisch, Pizza, Eis, Tiefkuehlgemuese), etc.',
   wtag_id                             NUMBER(38,0)    NOT NULL COMMENT 'ID des Wochentags. Mo - So = 1 - 7.',
   zeitslot_id                         NUMBER(38,0)    NOT NULL COMMENT 'ID des Zeitslots fuer die Kalkulation und Bestellung von zusaetzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_MANDANT_AUSLIEFERUNGSGRUPPE_TAG_ZEITSLOTS_ZU PRIMARY KEY (mandant_id, auslieferungsgruppe_id, wtag_id, zeitslot_id) NOT ENFORCED
)  COMMENT = 'SCM-WBS - This table contains the standard settings of time slots (zeitslot_id) in MSI processboard for each client (mandant_id), delivery group (auslieferungsgruppe_id) and weekday (wtag_id). A time slot concerns the calculation and resupply-reporting for additional promotional item_2 quantities. All possible time slots come from the list of options in wbs_l_mandant_zeitslots. For each delivery group clients can have only one time slot per weekday, but several delivery groups in one time slot are possible. Users can assign a different time slot in MSI, which is then stored in table ts_wbs_zeitslots_aenderung.';
