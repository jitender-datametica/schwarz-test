--==============================================================
-- Table: flw_art_marktpreis_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_marktpreis_per_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_MARKTPREIS_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeit aus gtvon',
   flw_version_id                      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'myMEAT Version zur Marktpreisermittlung aus versi',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeit aus gtbis',
   bruttopreis                         NUMBER(18,4)     NOT NULL COMMENT 'Preis aus brprs',
   menge                               NUMBER(18,3)     NOT NULL COMMENT 'Menge aus menge',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   dat_aenderung                       DATE             NOT NULL COMMENT 'Datum der Änderung aus updat. Dient als Bezugsdatum der Kursumrechnung',
   system_id                           NUMBER(38,0)     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   nettopreis                          NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Nettopreis aus ntprs',
   nicht_relevant_fg                   NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Flag legt fest, ob der Datensatz für die Auswertung relevant ist. Der Input kommt aus den SAP Tabellen spmeat_mpe_mozk und spmeat_mpe_zmop, die selbst nicht ins Datenmodell integriert werden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_MARKTPREIS_PER PRIMARY KEY (flw_art_id, werk_id, dat_von, flw_version_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - myMEAT MPE: Marktpreis aus spmeat_mpe_mprs';

