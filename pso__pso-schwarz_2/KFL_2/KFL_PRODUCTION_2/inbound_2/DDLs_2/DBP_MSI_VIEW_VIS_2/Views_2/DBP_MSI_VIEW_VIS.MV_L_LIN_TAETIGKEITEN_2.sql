CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_LIN_TAETIGKEITEN_2
(
mandant_id
,ausbildung_id
,ausbildung_bez
,lin_kursgruppe_id
,sonderabzug
,pauschalabzug
)
AS
   SELECT
   mandant_id, ausbildung_id, ausbildung_bez, lin_kursgruppe_id, sonderabzug, pauschalabzug
   FROM
   (
   SELECT CAST(1 AS BYTEINT) AS mandant_id, CAST('v_maks_basic' AS VARCHAR(30)) AS ausbildung_id, CAST('MAKS KiE (Kaufmann/ -frau im Einzelhandel)' AS VARCHAR(256)) AS ausbildung_bez, CAST('93' AS VARCHAR(10)) AS lin_kursgruppe_id, CAST(0 AS SMALLINT) AS sonderabzug, CAST(8 AS SMALLINT) AS pauschalabzug
   ) v01

   UNION

   SELECT
   mandant_id, ausbildung_id, ausbildung_bez, lin_kursgruppe_id, sonderabzug, pauschalabzug
   FROM
   (
   SELECT CAST(1 AS BYTEINT) AS mandant_id, CAST('v_maks_sales' AS VARCHAR(30)) AS ausbildung_id, CAST('MAKS Verkäufer Frische' AS VARCHAR(256)) AS ausbildung_bez, CAST('94' AS VARCHAR(10)) AS lin_kursgruppe_id, CAST(0 AS SMALLINT) AS sonderabzug, CAST(8 AS SMALLINT) AS pauschalabzug
   ) v02

   UNION

   SELECT
   mandant_id, ausbildung_id, ausbildung_bez, lin_kursgruppe_id, sonderabzug, pauschalabzug
   FROM
   (
   SELECT CAST(1 AS BYTEINT) AS mandant_id, CAST('v_maks_sales_f'AS VARCHAR(30)) AS ausbildung_id, CAST('MAKS Verkäufer Food' AS VARCHAR(256)) AS ausbildung_bez, CAST('95' AS VARCHAR(10)) AS lin_kursgruppe_id, CAST(0 AS SMALLINT) AS sonderabzug, CAST(8 AS SMALLINT) AS pauschalabzug
   ) v03

   UNION

   SELECT
   mandant_id, ausbildung_id, ausbildung_bez, lin_kursgruppe_id, sonderabzug, pauschalabzug
   FROM
   (
   SELECT CAST(1 AS BYTEINT) AS mandant_id, CAST('v_maks_abi' AS VARCHAR(30)) AS ausbildung_id, CAST('MAKS Abiturientenprogramm' AS VARCHAR(256)) AS ausbildung_bez, CAST('96' AS VARCHAR(10)) AS lin_kursgruppe_id, CAST(10 AS SMALLINT) AS sonderabzug, CAST(0 AS SMALLINT) AS pauschalabzug
   ) v04

   UNION

   SELECT
   mandant_id, ausbildung_id, ausbildung_bez, lin_kursgruppe_id, sonderabzug, pauschalabzug
   FROM
   (
   SELECT CAST(1 AS BYTEINT) AS mandant_id, CAST('v_maks_3lquereinstieg' AS VARCHAR(30)) AS ausbildung_id, CAST('MAKS 3LJQuereinstieg' AS VARCHAR(256)) AS ausbildung_bez, CAST('97' AS VARCHAR(10)) AS lin_kursgruppe_id, CAST(10 AS SMALLINT) AS sonderabzug, CAST(0 AS SMALLINT) AS pauschalabzug
   ) v05

;