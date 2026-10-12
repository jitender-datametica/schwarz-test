CREATE OR REPLACE TABLE ldl_data_production_etl.t407_supplier_bank_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c407_krednr STRING(7) NOT NULL,
c407_bank_id INTEGER,
c407_account STRING(18),
c407_iban STRING(34),
c407_charge_key STRING(2),
c407_check_key STRING(2),
c407_alt_payee STRING(7),
c407_paym_blocked INTEGER,
c407_avis_fax STRING(31),
c407_avis_email STRING(241),
c407_mod_date DATETIME,
c407_mod_user STRING(8),
c407_bv_typ STRING(4),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c407_krednr) NOT ENFORCED
);