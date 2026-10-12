--==============================================================
-- Table: wup_plan_kjmo_owg_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_plan_kjmo_owg_1
   generated from Powerdesigner on Dienstag, 28. Januar 2025 09:55:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_plan_kjmo_owg_1 (
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
hwg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
umsatz_netto_plan NUMERIC(18,2) OPTIONS(description='geplanter Nettoumsatz / Umsatzplanwert'),
abschriften_netto_operativ_plan NUMERIC(18,2)
OPTIONS(description='Abschriftenplanwert für operative Abschriften. Total- + Preisabschriften'),
betrag_vk_netto_inventur_diff_plan BIGNUMERIC(38,4)
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_1-Zeitraum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_id, nb_id, mandant_id, kjmo, hwg_id) NOT ENFORCED
) OPTIONS(description='VIS - Planwerte pro Markt / Mandant_1 / Monat_1 / Haupwarengruppe (hwg)');