CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_DIREKTE_ZUORDNUNG_1
(
direkte_zuordnung_fg
,direkte_zuordnung_bez
)
AS

   SELECT
   direkte_zuordnung_fg, direkte_zuordnung_bez
   FROM
   (
   SELECT
   1 AS direkte_zuordnung_fg, 'nur direkte Zuordnung' AS direkte_zuordnung_bez
   ) v01

   UNION

   SELECT
   direkte_zuordnung_fg, direkte_zuordnung_bez
   FROM
   (
   SELECT
   0 AS direkte_zuordnung_fg, 'alle Märkte' AS direkte_zuordnung_bez
   ) v02
;