--==============================================================
-- Table: tp_objekt_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_objekt_per
   generated from Powerdesigner on Mittwoch, 17. August 2022 14:39:53
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TP_OBJEKT_PER (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   tp_objekt_id                        NUMBER(38,0)    NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP',
   dat_von                             DATE            NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   techn_platz_id                      VARCHAR(30)     NOT NULL COMMENT 'Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit',
   dat_bis                             DATE            NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   tp_objekt_typ                       VARCHAR(1)      COMMENT 'Equipmenttyp',
   hersteller_name                     VARCHAR(30)     COMMENT 'Hersteller der Anlage',
   hersteller_land_id                  VARCHAR(2)      COMMENT 'Herstellerland',
   hersteller_typ_bez                  VARCHAR(20)     COMMENT 'Typenbezeichnung des Herstellers',
   hersteller_serial_id                VARCHAR(30)     COMMENT 'Serialnummer gemäß Hersteller',
   bau_kj                              NUMBER(38,0)    COMMENT 'Baujahr',
   bau_kjmo                            NUMBER(38,0)    COMMENT 'Baumonat',
   dat_gewaehrleistung_start           DATE            COMMENT 'Gewährleistungsdatum',
   dat_gewaehrleistung_ende            DATE            COMMENT 'Datum, an dem die Gewährleistung endet',
   tp_objekt_nr                        VARCHAR(30)     COMMENT 'Objektnummer',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TP_OBJEKT_PER PRIMARY KEY (mandant_id, tp_objekt_id, dat_von) NOT ENFORCED
)  COMMENT = 'IOS - Historisierte mandantenbezogene Stammtabelle für Objekte eines technischen Platzes.';
