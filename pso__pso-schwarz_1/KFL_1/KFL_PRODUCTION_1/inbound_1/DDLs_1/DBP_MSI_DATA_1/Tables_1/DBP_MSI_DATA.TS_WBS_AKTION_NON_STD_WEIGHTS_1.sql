--==============================================================
-- Table: ts_wbs_aktion_non_std_weights_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_aktion_non_std_weights_1
   generated from Powerdesigner on Donnerstag, 1. Dezember 2022 18:54:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WBS_AKTION_NON_STD_WEIGHTS_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH.',
   werbe_typ_id                        NUMBER(38,0)    NOT NULL COMMENT 'Werbetyp-ID. sollte werbe_typ_id heißen (eine_1 weitere Bezeichnung für den gleichen Inhalt ist unnötig). Ein Werbetyp ist ein Standardwerbezeitraum. Dieser sagt je Mandant_1 aus, von welchem bis zu welchem Wochentag eine_1 Aktion_1 geht. (Die festgelegten Tage eines Eintrags lassen sich danach aber manuell verändern = abweichender Werbezeitraum.)',
   kjwo                                NUMBER(38,0)    NOT NULL COMMENT 'Kalenderwoche in der die Aktion_1 startet.',
   dat_quelle                          DATE            NOT NULL COMMENT 'Quelldatum, von dem die prozentualen Abverkäufe der Werbeartikel abgezogen und auf ein anderes Zieldatum umverteilt werden. Von einem Quelldatum kann mehrmals abgezogen und an verschiedene Zieldaten verteilt werden.',
   dat_ziel                            DATE            NOT NULL COMMENT 'Zieldatum, an das die prozentualen Abverkäufe Werbemenge umverteilt werden (die vom Quelldatum abgezogen wurden).',
   gewichtung_prz                      NUMBER(38,3)    COMMENT 'Gewichtungen für Hadoop oder Databricks. Prozentsatz der Abverkäufe der Werbeartikel. Wird teils gespeichert als Zahl zwischen 0 und 100.',
   dat_von_orig                        DATE            NOT NULL COMMENT 'Original promotion start. Calculation of promotion start/-end-Date similar to MV_WERBE_WOCHE_WBS.',
   dat_bis_orig                        DATE            NOT NULL COMMENT 'Original promotion end. Calculation of promotion start/-end-Date similar to MV_WERBE_WOCHE_WBS.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_AKTION_NON_STD_WEIGHTS PRIMARY KEY (mandant_id, werbe_typ_id, kjwo, dat_quelle, dat_ziel) NOT ENFORCED
)  COMMENT = 'SCM-WBS - Weights for WBS non-standard promotion calculation, content maintained by transaction services document. Weights signal how much (in percent) of the expected sales_1 of promotional goods is transferred from a source to a target date, in case of a non-std promotion with different dates.';
