CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_gutschein_1 (
  crm_gutschein_id STRING(36) COLLATE 'und:ci' NOT NULL OPTIONS (
    description='Gutschein_1 ID (GUID) aus CRM.'
  ),
  crm_vorgang_id STRING(36) COLLATE 'und:ci' OPTIONS (
    description='Vorgang ID (GUID) aus CRM.'
  ),
  crm_gutschein_grund_id INT64 OPTIONS (
    description='Grund der Gutscheinausgabe ID.'
  ),
  gutschein_nummer STRING(100) COLLATE 'und:ci' OPTIONS (
    description='Gutscheinnummer.'
  ),
  kostenstelle_id STRING(100) COLLATE 'und:ci' OPTIONS (
    description='Kostenstelle.'
  ),
  gutschein_wert NUMERIC(10, 2) NOT NULL OPTIONS (
    description='Gutscheinwert.'
  ),
  td_update TIMESTAMP OPTIONS (
    description='Technical fields for synchronisation framework. Will be delted after last product migration'
  ),
  td_insert TIMESTAMP OPTIONS (
    description='Technical fields for synchronisation framework. Will be delted after last product migration'
  ),
  mandant_id INT64 OPTIONS (
    description='Mandant_1 im DWH.'
  ),
  wrg_id STRING(3) OPTIONS (
    description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'
  )
)
OPTIONS (
  description='KMR - Gutscheindaten aus der CRM Entität kl_voucher - MS Dynamics CRM'
);