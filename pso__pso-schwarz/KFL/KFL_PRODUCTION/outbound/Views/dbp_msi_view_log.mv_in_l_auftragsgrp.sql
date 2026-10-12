CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_l_auftragsgrp (auftragsgrp_id, technikbereich_bez) AS ((SELECT
   SUBSTR('CS3', 1, 3) AS auftragsgrp_id,
   'FFZ' AS technikbereich_bez
  UNION DISTINCT
  SELECT SUBSTR('CS4', 1, 3) AS auftragsgrp_id,
   'Haustechnik' AS technikbereich_bez)
 UNION DISTINCT
 SELECT SUBSTR('CS5', 1, 3) AS auftragsgrp_id,
  'Automatisierungstechnik' AS technikbereich_bez)
UNION DISTINCT
SELECT SUBSTR('CS7', 1, 3) AS auftragsgrp_id,
 'Reinigung' AS technikbereich_bez;