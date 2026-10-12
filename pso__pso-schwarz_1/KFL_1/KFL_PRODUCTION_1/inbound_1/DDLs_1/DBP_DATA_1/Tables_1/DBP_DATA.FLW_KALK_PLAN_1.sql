--==============================================================
-- Table: flw_kalk_plan_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_plan_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KALK_PLAN_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   plan_kalk_id                        NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID der Plankalkulation aus clpnr',
   schnittliste_id                     NUMBER(18,0)     NOT NULL COMMENT 'ID der Schnittliste aus ctlnr',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat_kalk_ab                         DATE             NOT NULL COMMENT 'Kalkulationsdatum ab aus kadat',
   dat_kalk_bis                        DATE             NOT NULL COMMENT 'Kalkulationsdatum bis aus bidat',
   fortgesch_kalk_fg                   NUMBER(38,0)     NOT NULL COMMENT 'In SAP werden fortgeschriebene Kalkulationen durch einen Eintrag in fsnam identifiziert. Im DWH wird nur ein Flag benötigt.',
   kalk_variante_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine_1 Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   plan_soll_kz                        VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Bedeutung der Kalkulation. P wie Plan ist Wochenvorplanung, S Soll= Tageplanung auf Basis Ist- Eingangsmengen. Versorgung über Hyperion',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KALK_PLAN PRIMARY KEY (mandant_id, plan_kalk_id) NOT ENFORCED
)  COMMENT = 'FLW - Plankalkulation aus clpk und aus Hyperion';

