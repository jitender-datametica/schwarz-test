--==============================================================
-- Table: ims_mamo_qualifier_ref_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_mamo_qualifier_ref_wup_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMS_MAMO_QUALIFIER_REF_WUP_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   ref_wup_id                          INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   qualifier_id                        INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Qualifiers (Surrogate Key DWH - Basis Qualifier Bezeichnung (Upload Fachbereich))',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMS_MAMO_QUALIFIER_REF_WUP_ZU PRIMARY KEY (mandant_id, ref_wup_id, nb_id, qualifier_id) NOT ENFORCED
)  COMMENT = 'IMS - Marktmodernisierung Qualifier (Referenzmärkte für den Erfolgsvergleich einer Mamo-Maßnahme - Zusammenfassung über einen Qualifier) (Bsp. Region Südwest) - manueller Upload via Sharepoint';
