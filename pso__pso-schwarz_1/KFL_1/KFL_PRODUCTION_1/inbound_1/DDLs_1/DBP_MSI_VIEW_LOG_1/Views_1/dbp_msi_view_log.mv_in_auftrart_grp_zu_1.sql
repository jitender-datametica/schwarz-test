CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_AUFTRART_GRP_ZU_1(
	AUFTRAGSART_ID,
	AUFTRAGSGRP_ID
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial
    SELECT *
   FROM
   (SELECT
   CAST('CS34' AS CHAR(4)) AS auftragsart_id, CAST('CS3' AS CHAR(3)) AS auftragsgrp_id
   ) v01
   UNION
    SELECT *
   FROM
   (SELECT
   CAST('CS35' AS CHAR(4)) AS auftragsart_id, CAST('CS3' AS CHAR(3)) AS auftragsgrp_id
   ) v01
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS36' AS CHAR(4)) AS auftragsart_id, CAST('CS3' AS CHAR(3)) AS auftragsgrp_id
   ) v02
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS37' AS CHAR(4)) AS auftragsart_id, CAST('CS3' AS CHAR(3)) AS auftragsgrp_id
   ) v03 
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS44' AS CHAR(4)) AS auftragsart_id, CAST('CS4' AS CHAR(3)) AS auftragsgrp_id
   ) v04
    UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS45' AS CHAR(4)) AS auftragsart_id, CAST('CS4' AS CHAR(3)) AS auftragsgrp_id
   ) v04
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS46' AS CHAR(4)) AS auftragsart_id, CAST('CS4' AS CHAR(3)) AS auftragsgrp_id
   ) v05
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS47' AS CHAR(4)) AS auftragsart_id, CAST('CS4' AS CHAR(3)) AS auftragsgrp_id
   ) v06
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS55' AS CHAR(4)) AS auftragsart_id, CAST('CS5' AS CHAR(3)) AS auftragsgrp_id
   ) v07
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS56' AS CHAR(4)) AS auftragsart_id, CAST('CS5' AS CHAR(3)) AS auftragsgrp_id
   ) v08
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS57' AS CHAR(4)) AS auftragsart_id, CAST('CS5' AS CHAR(3)) AS auftragsgrp_id
   ) v09
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS76' AS CHAR(4)) AS auftragsart_id, CAST('CS7' AS CHAR(3)) AS auftragsgrp_id
   ) v10
   UNION
   SELECT *
   FROM
   (SELECT
   CAST('CS77' AS CHAR(4)) AS auftragsart_id, CAST('CS7' AS CHAR(3)) AS auftragsgrp_id
   ) v11
;