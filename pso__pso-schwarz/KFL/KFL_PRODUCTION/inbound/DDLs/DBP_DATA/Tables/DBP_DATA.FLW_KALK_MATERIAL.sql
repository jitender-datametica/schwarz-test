--==============================================================
-- Table: flw_kalk_material
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_material
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KALK_MATERIAL (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   materialwert_kalk_id                NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID zur Materialwertkalkulation aus clcnr',
   schnittliste_id                     NUMBER(18,0)     NOT NULL COMMENT 'ID der Schnittliste aus ctlnr. Referenz zu flw_schnittliste',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat_kalk_ab                         DATE             NOT NULL COMMENT 'Kalkulationsdatum ab aus kadat',
   dat_kalk_bis                        DATE             NOT NULL COMMENT 'Kalkulationsdatum bis aus bidat',
   fortgesch_kalk_fg                   NUMBER(38,0)     NOT NULL COMMENT 'In SAP werden fortgeschriebene Kalkulationen durch einen Eintrag in fsnam identifiziert. Im DWH wird nur ein Flag benötigt.',
   kalk_variante_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   plan_soll_kz                        VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Bedeutung der Kalkulation. P wie Plan ist Wochenvorplanung, S Soll= Tageplanung auf Basis Ist- Eingangsmengen. Versorgung über Hyperion',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KALK_MATERIAL PRIMARY KEY (mandant_id, materialwert_kalk_id) NOT ENFORCED
)  COMMENT = 'FLW - Materialwertkalkulation aus spmeat_clck und aus Hyperion';

