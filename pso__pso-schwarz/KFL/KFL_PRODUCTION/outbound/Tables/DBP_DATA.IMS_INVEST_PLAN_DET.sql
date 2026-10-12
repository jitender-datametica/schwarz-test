--==============================================================
-- Table: ims_invest_plan_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_invest_plan_det
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_invest_plan_det (
gj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftsjahr, auf das die Kosten geplant werden, Format JJJJ            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
hr_plan_gesamt_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen für eine Hochrechnung (=1) oder Plan (=0) oder Gesamtplan (=2) oder Ursprung Gesamt Maßnahmen Plan (=3)'),
excel_zeile BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer der Zeile aus dem zugrunde liegenden Excel-Sheet zur eindeutigen Identifizierung'),
berichts_pos_invest_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Berichtsposition- Gruppierung  wird direkt im DWH gepflegt '),
in_massnahme_typ_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID eins Massnahmetyps'),
plan_betrag NUMERIC(18,4) OPTIONS(description='geplanter Betrag'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
sparte_id BIGNUMERIC(38,0) OPTIONS(description='ID der Sparte'),
psp_id BIGNUMERIC(38,0)
OPTIONS(description='eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, hr_plan_gesamt_kz, excel_zeile, gj) NOT ENFORCED
) OPTIONS(description='IMS - Detailtabelle der Planung - wird aus Excel geladen');