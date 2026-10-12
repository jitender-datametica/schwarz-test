--==============================================================
-- Table: crm_kundenkarte_art_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kundenkarte_art_spr_zu_2
   generated from Powerdesigner on Dienstag, 5. August 2025 17:32:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_KUNDENKARTE_ART_SPR_ZU_2 (
   crm_kundenkarte_art_id              NUMBER(38,0)     NOT NULL COMMENT 'Art_2 der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   crm_kundenkarte_art_bez             VARCHAR(200)     COLLATE 'en-ci' COMMENT 'Bezeichnung des Kundenkartentyps.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_KUNDENKARTE_ART_SPR_ZU PRIMARY KEY (crm_kundenkarte_art_id, spr_id) NOT ENFORCED
)  COMMENT = 'EK-KUN - CosmosDB CRM - Sprachzuordnungstabelle zu Art_2 der Kundenkarte.';
