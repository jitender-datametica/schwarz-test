--==============================================================
-- Table: l_pruef_prozess_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_pruef_prozess_typ_1
   generated from Powerdesigner on Mittwoch, 21. Februar 2024 15:28:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_PRUEF_PROZESS_TYP_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   pruef_prozess_typ_kz                VARCHAR(10)      NOT NULL COMMENT 'Kennzeichen des Prüf-Prozesses. Aktuell nur ''MAX'', in Zukunft weitere Prozesse geplant.',
   pruef_prozess_typ_bez               VARCHAR(100)     NOT NULL COMMENT 'Bezeichnung des Prüf-Prozesses.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_PRUEF_PROZESS_TYP PRIMARY KEY (mandant_id, pruef_prozess_typ_kz) NOT ENFORCED
)  COMMENT = 'Tabelle beinhaltet verschiedene Arten von Prüf-Prozessen in den Filialen.';
