--==============================================================
-- Table: crm_l_kundenkarte_art_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_kundenkarte_art_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_KUNDENKARTE_ART_1 (
   crm_kundenkarte_art_id              NUMBER(38,0)     NOT NULL COMMENT 'Art_1 der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_KUNDENKARTE_ART PRIMARY KEY (crm_kundenkarte_art_id) NOT ENFORCED
)  COMMENT = 'EK-KUN - MSDynamicsCRM - Lookup Art_1 der Kundenkarte (Entitaet "arvato_loyaltycard")';

