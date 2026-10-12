CREATE OR REPLACE TABLE kfl_production_dbp_data.cos_bonuskauf_kunde_zu_1 (
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='Eindeutige ID einer Bonuskaufaktion z.Bsp. 700, aus bbynr.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
crm_kunde_id STRING(144) NOT NULL OPTIONS(description='CRM Kundenkarte-ID.'),
kauf_id STRING(144) DEFAULT '-1' NOT NULL OPTIONS(description='ID des kaufbaren Coupons (kaufbare Coupons).'),
anz_einloesung INTEGER NOT NULL OPTIONS(description='Anzahl wie oft eingelöst.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
dat_kauf_rueckgabe TIMESTAMP
OPTIONS(description='Datum und Zeit_1 wann Coupon zurückgegeben wurde (kaufbare Coupons).'),
dat_kauf TIMESTAMP
OPTIONS(description='Datum und Zeit_1 wann Coupon gekauft wurde (kaufbare Coupons).'),
kauf_status_nr INTEGER OPTIONS(description='Status_1 des kaufbaren Coupons (kaufbare Coupons).'),
anz_kaufbar INTEGER OPTIONS(description='Anzahl kaufbare Coupons (kaufbare Coupons).'),
dat_kauf_einloesung TIMESTAMP
OPTIONS(description='Datum und Zeit_1 der Einlösung (kaufbare Coupons).'),
status_aktiv_nr INTEGER OPTIONS(description='Aktivierungsstatus in der App: 1 = aktiv; 2 = nicht aktiviert.'),
datzeit_status_aktivierung TIMESTAMP
OPTIONS(description='Enthält Aktivierungsdatum und -zeit_1 des Coupons.'),
status_einloesung INTEGER
OPTIONS(description='Einlösestatus: 0 = noch nicht eingelöst; 1 = teilweise eingelöst; 2 = eingelöst.'),
dat_status_einloesung TIMESTAMP OPTIONS(description='Datum und Zeit_1 der Einlösung.'),
kontrollgruppe INTEGER OPTIONS(description='Kontrollgruppe Reco.'),
kampagnen_id STRING(20) OPTIONS(description='Campaign ID.'),
checkout_fg INTEGER OPTIONS(description='Flag: Handelt es sich um einen Checkout Coupon Coupon.'),
anz_kauf_ist INTEGER OPTIONS(description='Häufigkeit bisheriger Einkäufe.'),
anz_kauf_soll INTEGER OPTIONS(description='Häufigkeit noch offener Einkäufe.'),
sum_kauf_ist NUMERIC(18,4) OPTIONS(description='Bisherige Summe der Einkäufe.'),
sum_kauf_soll NUMERIC(18,4) OPTIONS(description='Noch offene Summe.'),
dat_update TIMESTAMP OPTIONS(description='Update Datum und Zeit_1 dieser Tabelle.'),
kampagnen_version INTEGER OPTIONS(description='Kampagnenversion.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bonuskauf_id, crm_kunde_id, kauf_id, anz_einloesung) NOT ENFORCED
) OPTIONS(description='Customer Coupon Assignments - Redemption Count-Size of Control Group Reco.');