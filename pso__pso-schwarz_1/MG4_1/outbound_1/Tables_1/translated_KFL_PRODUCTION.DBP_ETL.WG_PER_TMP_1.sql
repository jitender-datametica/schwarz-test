CREATE OR REPLACE TABLE kfl_production_dbp_etl.wg_per_tmp_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab welchem dieser Mehrwertsteuersatz gilt. Format\'YYYY-MM_1-DD\''),
lead_mwst_id INTEGER NOT NULL OPTIONS(description='führende Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
abt_id INTEGER
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte ID\'s, positive Werte: aus Stammdatensystem übernommen'),
dat_bis DATE OPTIONS(description='Datum, bis zu welchem dieser Mehrwertsteuersatz gilt. Format\'YYYY-MM_1-DD\''),
owg_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
platzierungswg_id INTEGER OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel'),
werbeteam_cd STRING(100) OPTIONS(description='Code des Werbeteams'),
PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, dat_von) NOT ENFORCED
);