CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ZEITENTWICKLUNG
(
zeit_id
,zeit_filter_id
,tag
)
AS
   SELECT
   cast(zeitraum.gj as Integer)  AS zeit_id, CAST('GJ'   || trim(zeitraum.akt_gj - eingabe.akt_gj) as VARCHAR(10)), eingabe.dat
   FROM dbp_view.v_tag eingabe
   CROSS JOIN dbp_view.v_jahr_gj zeitraum


   UNION
   ALL
   SELECT
   zeitraum.kjwo*10, CAST ('KW' || trim(zeitraum.akt_wo - eingabe.akt_wo) as VARCHAR(10) ) AS zeit_filter_id, eingabe.dat
   FROM dbp_view.v_tag eingabe
   CROSS JOIN dbp_view.v_tag zeitraum
   WHERE
   zeitraum.wtag_id = 7


   UNION
   ALL
   SELECT
   zeitraum.kjmo AS zeit_id, cast('Mon' || trim(zeitraum.akt_mo - eingabe.akt_mo) as VARCHAR(10)) AS zeit_filter_id, eingabe.dat
   FROM dbp_view.v_tag eingabe
   CROSS JOIN dbp_view.v_monat zeitraum;