--==============================================================
-- Table: ims_mamo_wup_schliessung_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_mamo_wup_schliessung_per_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMS_MAMO_WUP_SCHLIESSUNG_PER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_schliessung_von                 DATE             NOT NULL COMMENT 'Datum von dem ab der Markt für die Marktmodernisierungsmaßnahme geschlossen ist (können mehrere Schließungen pro Massnahme sein - mehrere Einträge in Tabelle)',
   dat_schliessung_bis                 DATE             COMMENT 'Datum bis zu dem der Markt für die Marktmodernisierungsmaßnahme geschlossen ist (können mehrere Schließungen pro Massnahme sein - mehrere Einträge in Tabelle)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMS_MAMO_WUP_SCHLIESSUNG_PER PRIMARY KEY (mandant_id, wup_id, nb_id, dat_schliessung_von) NOT ENFORCED
)  COMMENT = 'IMS - Schließungen (Verkaufsunterbrechungen) aufgrund von Marktmodernisierungsmassnahmen (Modernisierung oder Facelift) - manueller Upload via Sharepoint';
