--==============================================================
-- Table: l_crossdocking
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_crossdocking
   generated from Powerdesigner on Freitag, 28. März 2025 12:20:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_CROSSDOCKING (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   crossdocking_id                     INTEGER     NOT NULL COMMENT 'ID des Umschlagplatzs bzw. Cross Docking Orts.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_CROSSDOCKING PRIMARY KEY (mandant_id, crossdocking_id) NOT ENFORCED
)  COMMENT = 'Lookuptabelle für den Kaufland definierten Umschlagplatz bzw. Cross-Docking-Ort,an den die Waren zuerst vom Lieferanten versendet werden. Am Cross-Docking-Ort erfolgt dann die Verteilung auf die Länder (VZ/Märkte).';
