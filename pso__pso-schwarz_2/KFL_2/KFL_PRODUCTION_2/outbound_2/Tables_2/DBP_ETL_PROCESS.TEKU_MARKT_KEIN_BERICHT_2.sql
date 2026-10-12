CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.teku_markt_kein_bericht_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
kein_bericht_bez STRING(255)
OPTIONS(description='Hier ist ein Text hinterlegt, wer keinen Bericht bekommen soll. z.Bsp. HL_2 plus VKL_2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='TEKU Ladehilfstabelle - für Märkte und deren Hierarchie-Elemente, die keinen Bericht erhalten sollen.');