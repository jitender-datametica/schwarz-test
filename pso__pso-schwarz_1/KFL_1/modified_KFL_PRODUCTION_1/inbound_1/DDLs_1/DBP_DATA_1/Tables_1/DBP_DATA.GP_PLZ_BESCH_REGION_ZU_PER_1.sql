--==============================================================
-- Table: gp_plz_besch_region_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_plz_besch_region_zu_per_1
   generated from Powerdesigner on Freitag, 4. Juli 2025 08:55:29
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_PLZ_BESCH_REGION_ZU_PER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   gp_id                               INTEGER     NOT NULL COMMENT 'Lieferant.',
   land_id                             VARCHAR(2)       NOT NULL COMMENT 'Land_1 ID aus belos_adresse.',
   abholung_plz                        VARCHAR(10)      NOT NULL COMMENT 'Postleitzahl (muss nicht = gp_plz sein, bzw. sind mehrere pro GP_1 möglich).',
   dat_von                             DATE             NOT NULL COMMENT 'Gültigkeitsdatum von.',
   dat_bis                             DATE             COMMENT 'Gültigkeitsdatum bis.',
   besch_region_id                     INTEGER     COMMENT 'Beschaffungsregion SCM.',
   besch_region_koordination_id        INTEGER     COMMENT 'Beschaffungsregion SCM, welche die Koordination des Lieferanten übernimmt. Kann von besch_region_id abweichen.',
   anz_pal_stapelfaktor                NUMBER(29,3)     COMMENT 'Durchschnittliche Stapelfaktor (Anzahl Paletten übereinander) für den jeweiligen GP_1 (Lieferanten) und das zugehörige Gültigkeitsintervall. Dieser Wert ist eine_1 relevante Größe für die Abrechnung, insbesondere hinsichtlich der LKW-Auslastung. Der Wert dürfte in der Regel zwischen 1 und 5 liegen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP_PLZ_BESCH_REGION_ZU_PER PRIMARY KEY (mandant_id, gp_id, abholung_plz, dat_von, land_id) NOT ENFORCED
)  COMMENT = 'LOG - This table contains relations between supplier_1 (gp_id), zipcode of the pickup destination (abholung_plz) and procurement region_1 (Beschaffungsregion, besch_region_id and besch_region_koordination_id). A supplier_1 can have several addresses where goods are produced and picked up by transporters, which can therefore have different zip codes from the gp_plz of the main gp_1 office. A Beschaffungsregion is a procurement region_1; besch_region_id is the one where the procurement happens, while besch_region_koordination_id can be a different one because the coordinating office region_1 can be different from the pickup region. Both of them refer to besch_region_id in ts_l_beschaffungsregion. Filled through Sharepoint-Upload.';
