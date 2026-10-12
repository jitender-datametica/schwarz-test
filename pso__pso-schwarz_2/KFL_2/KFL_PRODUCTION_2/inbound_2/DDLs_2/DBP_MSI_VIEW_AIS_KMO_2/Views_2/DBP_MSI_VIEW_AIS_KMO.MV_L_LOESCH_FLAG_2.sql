CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_LOESCH_FLAG_2
(
loesch_fg
,loesch_fg_bez
)
AS

   SELECT
   loesch_fg,
   loesch_fg_bez
   FROM
   (
   SELECT
   CAST (0 AS BYTEINT)  AS loesch_fg,
   CAST('Anlegen' AS CHAR(10)) AS loesch_fg_bez
   ) t1_2

   UNION

   SELECT
   loesch_fg,
   loesch_fg_bez
   FROM
   (SELECT
   CAST (1 AS BYTEINT)  AS loesch_fg,
   CAST('Löschen' AS CHAR(10)) AS loesch_fg_bez
   ) t2
;