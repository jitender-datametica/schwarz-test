--==============================================================
-- Table: ims_mamo_wup_qualifier_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_mamo_wup_qualifier_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMS_MAMO_WUP_QUALIFIER_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   qualifier_id                        NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Qualifiers (Surrogate Key DWH - Basis Qualifier Bezeichnung (Upload Fachbereich))',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMS_MAMO_WUP_QUALIFIER_ZU PRIMARY KEY (mandant_id, wup_id, nb_id, qualifier_id) NOT ENFORCED
)  COMMENT = 'IMS - Mapping einer Fokusfiliale (WUP) zu einem Qualifier (Zuweisung von Referenzmärkten) - manueller Upload via Sharepoint';
