--==============================================================
-- Table: l_mgg_gruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_mgg_gruppe
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 13:50:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_MGG_GRUPPE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   mgg_gruppe_id                       INTEGER     NOT NULL COMMENT 'ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.',
   mgg_abteilung_id                    INTEGER     COMMENT 'ID der MGG (Mengengerüst) Abteilung. Fasst mehrere MGG Gruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_MGG_GRUPPE PRIMARY KEY (mandant_id, mgg_gruppe_id) NOT ENFORCED
)  COMMENT = 'Wird zur Ermittlung Abweichungsgrad MGG benötigt. Ebene der Flächenhierarchie in VIS SOK. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Gruppe zusammen. Wird manuell in VIS SOK gepflegt.';