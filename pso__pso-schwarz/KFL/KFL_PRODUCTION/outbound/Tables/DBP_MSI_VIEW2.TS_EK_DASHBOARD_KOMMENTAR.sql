--==============================================================
-- Table: ts_ek_dashboard_kommentar
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ek_dashboard_kommentar
   generated from Powerdesigner on Wednesday, 15 May 2024 20:18:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view2.ts_ek_dashboard_kommentar (
ek_dashboard_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Dossier-ID bzw. Dashboard-ID, über welche das MSTR Attribut je Dossier den richtigen Kommentar anzeigen kann.'),
kommentar_txt STRING(10000) NOT NULL
OPTIONS(description='Nutzerkommentar, welcher als Textrattribut im Dossier 1:1 angezeigt wird. Wird u.a. verwendet, um Nutzer auf Eigenheiten der Dashboarddaten hinzuweisen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ek_dashboard_id) NOT ENFORCED
)
OPTIONS(description='AIS - Kommentarfeld für die AIS DE EKCO Dossiers / Dashboards. Je Dossier ein Kommentar. Nicht historisiert sondern immer nur der neueste Wert. Der aktuell gepflegte Wert wird via Attribut im Dossier angezeigt.');