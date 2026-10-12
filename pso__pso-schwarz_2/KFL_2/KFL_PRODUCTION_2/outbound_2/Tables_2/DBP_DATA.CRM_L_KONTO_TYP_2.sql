CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_konto_typ_2 (
crm_konto_typ_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='EK-INTEGER  - MSDynamicsCRM - Typ des Loyaltyaccounts');