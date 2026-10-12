--==============================================================
-- Table: ts_wbs_zeitslots_aenderung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_zeitslots_aenderung_1
   generated from Powerdesigner on Wednesday, August 24, 2022 12:57:02 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WBS_ZEITSLOTS_AENDERUNG_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH.',
   auslieferungsgruppe_id              VARCHAR(4)      NOT NULL COMMENT 'ID der Auslieferungsgruppe. Eine_1 Auslieferungsgruppe (manchmal auch Ausliefergruppe) ist eine_1 Buendelung von Artikeln mit gleichen Eigenschaften Aufgrund welchen sie zusammen ausgeliefert werden koennen, VZ in Richtung Filiale. Z.B.: Food Trocken (Mehl, Konserven, Nudeln), Tiefkuehlware (Fisch, Pizza, Eis, Tiefkuehlgemuese), etc.',
   dat                                 DATE            NOT NULL COMMENT 'Datum fuer das die Aenderung im Processboard gilt.',
   zeitslot_id                         NUMBER(38,0)    NOT NULL COMMENT 'ID des Zeitslots fuer die Kalkulation und Bestellung von zusaetzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_ZEITSLOTS_AENDERUNG PRIMARY KEY (mandant_id, zeitslot_id, auslieferungsgruppe_id, dat) NOT ENFORCED
)  COMMENT = 'SCM-WBS - This table saves the changes made by users in MSI processboard to the standard time slots (zeitslot_id) in table wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu. Changes are for a date (dat), client (mandant_id) and delivery group (auslieferungsgruppe_id). Users can only pick from the list of available options that are stored in table wbs_l_mandant_zeitslots. Each subsequent time slot change overwrites the last setting while choosing the standard again deletes the entry.';
