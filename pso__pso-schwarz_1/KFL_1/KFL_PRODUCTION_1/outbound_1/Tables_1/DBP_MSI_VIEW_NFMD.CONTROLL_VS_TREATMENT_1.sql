CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.controll_vs_treatment_1 (
wup_id INTEGER OPTIONS(description='Marktnummer'),
ctrl_v_test_cd STRING(12) OPTIONS(description='Kontroll oder Testfiliale')
) OPTIONS(description='NFMD Tabelle verruebergehend fuer die Auswertung des Pilotens');