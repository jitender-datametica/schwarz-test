CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_L_AUFTRAGSGRP_1
--AP0026639: added CS7
(
mandant_id
,auftragsgrp_id
,technikbereich_bez
)
AS

   SELECT v100.*, v99.*

   FROM
   (
   SELECT *
   FROM
   (SELECT
   CAST('CS3' AS CHAR(3)) AS auftragsgrp_id, CAST('FFZ' AS VARCHAR(50)) AS technikbereich_bez
   ) v01

   UNION

   SELECT *
   FROM
   (SELECT
   CAST('CS4' AS CHAR(3)) AS auftragsgrp_id, CAST('Haustechnik' AS VARCHAR(50)) AS technikbereich_bez
   ) v04

   UNION

   SELECT *
   FROM
   (SELECT
   CAST('CS5' AS CHAR(3)) AS auftragsgrp_id, CAST('Automatisierungstechnik' AS VARCHAR(50)) AS technikbereich_bez
   ) v07

   UNION

   SELECT *
   FROM
   (SELECT
   CAST('CS7' AS CHAR(3)) AS auftragsgrp_id, CAST('Reinigung' AS VARCHAR(50)) AS technikbereich_bez
   ) v08

   ) v99
   CROSS JOIN
   (
   SELECT mandant_id
   FROM dbp_view.v_mandant_1
   ) v100;