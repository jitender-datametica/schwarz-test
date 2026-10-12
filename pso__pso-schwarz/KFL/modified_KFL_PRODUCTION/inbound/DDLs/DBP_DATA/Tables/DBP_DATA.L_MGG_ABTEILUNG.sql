--==============================================================
-- Table: l_mgg_abteilung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_mgg_abteilung
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:36:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_MGG_ABTEILUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   mgg_abteilung_id                    INTEGER     NOT NULL COMMENT 'ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.',
   food_nonfood_kategorie_id           INTEGER     COMMENT 'ID der Food / Non Food Kategorie. ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_MGG_ABTEILUNG PRIMARY KEY (mandant_id, mgg_abteilung_id) NOT ENFORCED
)  COMMENT = 'Wird zur Ermittlung Abweichungsgrad MGG (Mengengerüst) benötigt. Ebene der Flächenhierarchie in VIS SOK. Fasst mehrere MGG Gruppen zu einer übergeordneten Hierarchie-Ebene zusammen. Wird manuell in VIS SOK gepflegt.';
