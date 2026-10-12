CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_in_auftrart_grp_zu (mandant_id, auftragsart_id, auftragsgrp_id)
AS SELECT v100.mandant_id,
 v99.auftragsart_id,
 v99.auftragsgrp_id
FROM ((((((((((SELECT SUBSTR('CS35', 1, 4) AS auftragsart_id,
             SUBSTR('CS3', 1, 3) AS auftragsgrp_id
            UNION DISTINCT
            SELECT SUBSTR('CS36', 1, 4) AS auftragsart_id,
             SUBSTR('CS3', 1, 3) AS auftragsgrp_id)
           UNION DISTINCT
           SELECT SUBSTR('CS37', 1, 4) AS auftragsart_id,
            SUBSTR('CS3', 1, 3) AS auftragsgrp_id)
          UNION DISTINCT
          SELECT SUBSTR('CS45', 1, 4) AS auftragsart_id,
           SUBSTR('CS4', 1, 3) AS auftragsgrp_id)
         UNION DISTINCT
         SELECT SUBSTR('CS46', 1, 4) AS auftragsart_id,
          SUBSTR('CS4', 1, 3) AS auftragsgrp_id)
        UNION DISTINCT
        SELECT SUBSTR('CS47', 1, 4) AS auftragsart_id,
         SUBSTR('CS4', 1, 3) AS auftragsgrp_id)
       UNION DISTINCT
       SELECT SUBSTR('CS55', 1, 4) AS auftragsart_id,
        SUBSTR('CS5', 1, 3) AS auftragsgrp_id)
      UNION DISTINCT
      SELECT SUBSTR('CS56', 1, 4) AS auftragsart_id,
       SUBSTR('CS5', 1, 3) AS auftragsgrp_id)
     UNION DISTINCT
     SELECT SUBSTR('CS57', 1, 4) AS auftragsart_id,
      SUBSTR('CS5', 1, 3) AS auftragsgrp_id)
    UNION DISTINCT
    SELECT SUBSTR('CS76', 1, 4) AS auftragsart_id,
     SUBSTR('CS7', 1, 3) AS auftragsgrp_id)
   UNION DISTINCT
   SELECT SUBSTR('CS77', 1, 4) AS auftragsart_id,
    SUBSTR('CS7', 1, 3) AS auftragsgrp_id) AS v99
 INNER JOIN (SELECT mandant_id
  FROM kfl_production_dbp_view.v_mandant) AS v100 ON TRUE;