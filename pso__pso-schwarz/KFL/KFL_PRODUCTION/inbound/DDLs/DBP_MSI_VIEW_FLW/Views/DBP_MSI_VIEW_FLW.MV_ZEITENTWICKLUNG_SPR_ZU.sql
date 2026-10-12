CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_ZEITENTWICKLUNG_SPR_ZU
(
zeit_id
,spr_id
,zeitentwicklung_bez
)
AS

   
   SELECT
   kjmo       AS  zeit_id, 22           AS  spr_id,  to_char ( dat, 'Mon, YYYY') AS zeitentwicklung_bez
   FROM dbp_view.v_tag
   WHERE   EXTRACT( DAY FROM dat)  = 1
  

   UNION  ALL

   SELECT
   gj AS zeit_id, 22  AS spr_id, 'GJ '   ||  trim(gj) AS zeitentwicklung_bez
   FROM dbp_view.v_jahr_gj


   UNION  ALL

   SELECT

   kjwo * 10 AS  zeit_id, 22 spr_id, 'KW '  || substr(trim(kjwo),5)  || ' ' || trim(kj) AS  zeit_bez

   FROM dbp_view.v_tag
   WHERE
   wtag_id = 7;