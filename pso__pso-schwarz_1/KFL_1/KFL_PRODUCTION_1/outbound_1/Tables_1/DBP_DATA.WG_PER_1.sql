--==============================================================
-- Table: wg_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_per_1
   generated from Powerdesigner on Freitag, 11. Oktober 2024 15:09:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab welchem dieser Mehrwertsteuersatz gilt. Format\'YYYY-MM_1-DD\''),
lead_mwst_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='führende Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
abt_id BIGNUMERIC(38,0)
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte ID\'s, positive Werte: aus Stammdatensystem übernommen'),
dat_bis DATE OPTIONS(description='Datum, bis zu welchem dieser Mehrwertsteuersatz gilt. Format\'YYYY-MM_1-DD\''),
owg_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
platzierungswg_id BIGNUMERIC(38,0)
OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel'),
werbeteam_cd STRING(100) OPTIONS(description='Code des Werbeteams'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, dat_von) NOT ENFORCED
)
OPTIONS(description='TP1 - TP2 - Warengruppe - Stufe in der Artikelhierarchie             (ARTHIERTYP_ID nicht für PK benötigt)');