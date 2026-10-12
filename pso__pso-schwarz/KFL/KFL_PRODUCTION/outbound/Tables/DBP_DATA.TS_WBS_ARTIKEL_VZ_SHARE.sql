CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_wbs_artikel_vz_share (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Aktionsnummer'),
angebot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='aus TableName wbs_werbeaenderungen Offer/Angebot'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderwoche Aktionsstart'),
ausliefergruppe_id STRING(10) NOT NULL OPTIONS(description='Ausliefergruppe'),
gp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferantenummer aus lifnr. , Kontonummer des Lieferanten bzw. Kreditors'),
wup_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Verteilzentrum'),
nb_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb VZ'),
mandant_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant VZ'),
rank_share BIGNUMERIC(38,0) OPTIONS(description='Rank (Position des Shares)'),
share_wert BIGNUMERIC(38,0) OPTIONS(description='Share (Wert des Shares)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description=' Settings for WBS calculation core on product level / content maintained by transaction services document');