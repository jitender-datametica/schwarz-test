--==============================================================
-- Table: auslieferung_kopf_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: auslieferung_kopf_2
   generated from Powerdesigner on Mittwoch, 5. Juli 2023 10:31:29
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSLIEFERUNG_KOPF_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   beleg_guid                          VARCHAR(32)      NOT NULL COMMENT 'Beleg-ID.',
   belegtyp_id                         VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Belegtyp.',
   belegart_id                         VARCHAR(4)       COMMENT 'Belegart - Document type of the Delivery Order',
   beleg_id                            NUMBER(29,0)     COMMENT 'Belegnummer.',
   odo_typ_id                          VARCHAR(1)       COMMENT 'Outbound Delivery Order - Typ (leer = geplant, 0 = ausführbar, 1 = abweichend)',
   lief_pal_typ_akaf_id                VARCHAR(1)       COMMENT 'the type of pallet that is assembled by this automatic picking/assembling machine (AKAF)',
   anz_lt_geplant                      VARCHAR(5)       COMMENT 'Anzahl geplante Ladungsträger (Number of planned load carriers)',
   anz_hu_geplant                      VARCHAR(1)       COMMENT 'Anzahl geplanten Handling Units (Number of planned handling units)',
   akaf_anfragenummer                  VARCHAR(20)      COMMENT 'Key of transaction/operation that was performed by the automated picking machine (AKAF) in system that operates the machine',
   datzeit_erstellung                  TIMESTAMP_NTZ(9) COMMENT 'Anlagetimestamp.',
   datzeit_aenderung                   TIMESTAMP_NTZ(9) COMMENT 'Aenderungstimestamp.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUSLIEFERUNG_KOPF PRIMARY KEY (mandant_id, beleg_guid) NOT ENFORCED
)  COMMENT = 'Outbound Delivery Order Header.';
