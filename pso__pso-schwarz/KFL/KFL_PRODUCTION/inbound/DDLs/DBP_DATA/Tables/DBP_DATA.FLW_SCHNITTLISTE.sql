--==============================================================
-- Table: flw_schnittliste
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnittliste
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SCHNITTLISTE (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   schnittliste_id                     NUMBER(18,0)     NOT NULL COMMENT 'ID der Schnittliste aus ctlnr',
   sek_schl_id                         NUMBER(18,0)     NOT NULL COMMENT 'ID des Sekundärschlüssels aus sckey',
   sek_schl_typ_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Sekundärschlüssels aus sctyp',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   schnittliste_variante               NUMBER(38,0)     NOT NULL COMMENT 'Bariante der Schnittliste aus varia',
   dat_von                             DATE             NOT NULL COMMENT 'Gültigkeitsbeginn des Satzes aus gtvon',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültigkeitsende des Satzes aus gtbis',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SCHNITTLISTE PRIMARY KEY (mandant_id, schnittliste_id, sek_schl_id, sek_schl_typ_id) NOT ENFORCED
)  COMMENT = 'FLW - Schnittliste Kopf aus ctlk';

