CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_AUFTRART_GRP_ZU_1
----AP0026639: added CS7 mapping for CS76 and CS77
(
mandant_id
,auftragsart_id
,auftragsgrp_id
)
AS

   SELECT v100.*, v99.*

   FROM
   (
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

   ) v99
   CROSS JOIN
   (
   SELECT mandant_id
   FROM dbp_view.v_mandant_1
   ) v100;