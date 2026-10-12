--==============================================================
-- Table: abt_abt_grp_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abt_abt_grp_zu_1
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abt_abt_grp_zu_1 (
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
abt_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungsgruppe (z.B. Markt Gesamt, Markt vergleichbar, Food Frische, etc.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (abt_id, arthiertyp_id, mandant_id, abt_grp_id) NOT ENFORCED
) OPTIONS(description='VIS - Abteilung - Abteilungsgruppe Zuordnung');