--==============================================================
-- Table: transportation_unit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:27:21
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TRANSPORTATION_UNIT (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   transportation_unit_id              INTEGER     NOT NULL COMMENT 'Transporteinheit (intern)',
   kj_transportation_unit              INTEGER     NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
   transportation_unit_id_ext          VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Transporteinheit (extern)',
   lime_id                             VARCHAR(32)      COMMENT 'GUID Lokation',
   lime_id_ausgepackt                  VARCHAR(32)      COMMENT 'GUID Handling Unit (unpacked)',
   handling_unit_guid                  VARCHAR(32)      COMMENT 'GUID Handling Unit',
   transportmittel                     VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Transportmittel',
   eigentuemer                         VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Eigentümer',
   frachtfuehrer                       VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Frachtführer',
   scac                                VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Standard Carrier Alpha Code',
   max_anz_siegel                      INTEGER     COMMENT 'Max. Anzahl Siegel',
   fahrzeugnummer_intern               VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Interne Fahrzeugnummer',
   land_kfz_kennzeichen                VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Länderkennzeichen',
   kfz_kennzeichen                     VARCHAR(20)      COLLATE 'en-ci' COMMENT 'KFZ-Kennzeichen',
   tu_permanent_fg                     VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Flag: permanente Transporteinheit',
   tu_head_fg                          VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Flag: TU-Head',
   tor_vorbeladen_Fg                   VARCHAR(1)       COMMENT 'Flag: Tour muss vorbeladen sein',
   lkw_vorgekuehlt_fg                  VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Flag: LKW muss vorgekühlt werden',
   rundlauf_fg                         VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Flag: Rundlauf-Tour',
   hu_gewicht                          NUMBER(29,3)     COMMENT 'HU-Gewicht',
   hu_gewicht_menge_einh_id            VARCHAR(3)       COLLATE 'en-ci' COMMENT 'HU-Gewichtseinheit',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TRANSPORTATION_UNIT PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit) NOT ENFORCED
)  COMMENT = 'Transportation Unit';
