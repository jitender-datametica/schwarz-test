CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_in_l_auftragsgrp_1 (mandant_id, auftragsgrp_id, technikbereich_bez
) AS SELECT v100.mandant_id,
 v99.auftragsgrp_id,
 v99.technikbereich_bez
FROM (((SELECT SUBSTR('CS3', 1, 3) AS auftragsgrp_id,
      'FFZ' AS technikbereich_bez
     UNION DISTINCT
     SELECT SUBSTR('CS4', 1, 3) AS auftragsgrp_id,
      'Haustechnik' AS technikbereich_bez)
    UNION DISTINCT
    SELECT SUBSTR('CS5', 1, 3) AS auftragsgrp_id,
     'Automatisierungstechnik' AS technikbereich_bez)
   UNION DISTINCT
   SELECT SUBSTR('CS7', 1, 3) AS auftragsgrp_id,
    'Reinigung' AS technikbereich_bez) AS v99
 INNER JOIN (SELECT mandant_id
  FROM kfl_production_dbp_view.v_mandant_1) AS v100 ON TRUE;