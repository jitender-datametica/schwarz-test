CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_test_status_translation_2 (test_status, test_status_us,
test_status_gb) AS SELECT 'abgeschlossen' AS test_status,
 'finished' AS test_status_us,
 'finished' AS test_status_gb
UNION ALL
SELECT 'laufend' AS test_status,
 'running' AS test_status_us,
 'running' AS test_status_gb;