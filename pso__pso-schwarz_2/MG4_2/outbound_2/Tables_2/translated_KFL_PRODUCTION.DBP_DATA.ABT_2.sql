CREATE OR REPLACE TABLE kfl_production_dbp_data.abt_2 (
abt_id INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Mandant_2 im DWH'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (abt_id, arthiertyp_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Abteilung - oberste Stufe der Artikelhierarchie');