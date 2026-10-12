CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_L_AUFTRAGSGRP(
	AUFTRAGSGRP_ID,
	TECHNIKBEREICH_BEZ
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial

   SELECT * FROM
   
   (SELECT
   CAST('CS3' AS CHAR(3)) AS auftragsgrp_id, CAST('FFZ' AS VARCHAR(50)) AS technikbereich_bez
   ) v01

   UNION

   SELECT * FROM
   (SELECT
   CAST('CS4' AS CHAR(3)) AS auftragsgrp_id, CAST('Haustechnik' AS VARCHAR(50)) AS technikbereich_bez
   ) v04

   UNION

   SELECT * FROM
   (SELECT
   CAST('CS5' AS CHAR(3)) AS auftragsgrp_id, CAST('Automatisierungstechnik' AS VARCHAR(50)) AS technikbereich_bez
   ) v07

   UNION

   SELECT * FROM
   (SELECT
   CAST('CS7' AS CHAR(3)) AS auftragsgrp_id, CAST('Reinigung' AS VARCHAR(50)) AS technikbereich_bez
   ) v08

  ;