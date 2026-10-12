--==============================================================
-- Table: flw_charge_art_objekt_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_charge_art_objekt_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_CHARGE_ART_OBJEKT_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   objekt_nummer_id                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Objektnummer aus SAP Quelle INOB.CUOBJ',
   objekt_schluessel_id                VARCHAR(50)      NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Schlüssel des zu klassifizierenden Objektes aus SAP Quelle INOB.OBJEK',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_CHARGE_ART_OBJEKT_ZU PRIMARY KEY (mandant_id, objekt_nummer_id) NOT ENFORCED
)  COMMENT = 'FLW - Zuordnung einer internen Nummer zu einem bel. Objekt aus SAP P21 INOB';

