--==============================================================
-- Table: ts_ek_dashboard_kommentar
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ek_dashboard_kommentar
   generated from Powerdesigner on Wednesday, 15 May 2024 20:18:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW2.TS_EK_DASHBOARD_KOMMENTAR (
   ek_dashboard_id                     NUMBER(38,0)     NOT NULL COMMENT 'Dossier-ID bzw. Dashboard-ID, über welche das MSTR Attribut je Dossier den richtigen Kommentar anzeigen kann.',
   kommentar_txt                       VARCHAR(10000)   NOT NULL COMMENT 'Nutzerkommentar, welcher als Textrattribut im Dossier 1:1 angezeigt wird. Wird u.a. verwendet, um Nutzer auf Eigenheiten der Dashboarddaten hinzuweisen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_EK_DASHBOARD_KOMMENTAR PRIMARY KEY (ek_dashboard_id) NOT ENFORCED
)  COMMENT = 'AIS - Kommentarfeld für die AIS DE EKCO Dossiers / Dashboards. Je Dossier ein Kommentar. Nicht historisiert sondern immer nur der neueste Wert. Der aktuell gepflegte Wert wird via Attribut im Dossier angezeigt.';
