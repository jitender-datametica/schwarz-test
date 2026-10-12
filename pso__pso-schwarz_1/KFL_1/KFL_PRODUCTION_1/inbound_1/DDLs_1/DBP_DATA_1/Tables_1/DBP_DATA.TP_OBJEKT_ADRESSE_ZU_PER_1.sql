--==============================================================
-- Table: tp_objekt_adresse_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_objekt_adresse_zu_per_1
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:28:35
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TP_OBJEKT_ADRESSE_ZU_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   tp_objekt_id                        NUMBER(38,0)     NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk',
   standort_id                         VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID eines Standorts. Entspricht bei Bestandsmärkten der Marktnummer,  bei zukünftigen Standorten eine_1 Nummer bzw. bei Dummy_1-Standorten XXXX',
   tp_objekt_sort_id                   VARCHAR(30)      NOT NULL COMMENT 'Equipment - Sortierfeld',
   dat_von                             DATE             NOT NULL COMMENT 'Datum (von) - Date when record became valid',
   dat_bis                             DATE             COMMENT 'Datum (bis) - Date when record expired, and is no logner valid',
   instandhaltung_werk_id              NUMBER(38,0)     COMMENT 'Numerischer Surrogate key für das Werk werks. Plant where the equipment should be serviced. e. g. small fork lifters used in the stores are taken to the DCs for maintenance+repairs.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TP_OBJEKT_ADRESSE_ZU_PER PRIMARY KEY (tp_objekt_sort_id, mandant_id, werk_id, tp_objekt_id, standort_id, dat_von) NOT ENFORCED
)  COMMENT = 'Adressdaten zum Equipment aus SAP Industry (Tabelle EQUI_ADDR)';
