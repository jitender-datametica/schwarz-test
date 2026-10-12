CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_HERSTELLER_2
(
herst_id
,herst_name
,mandant_id
,strasse
,plz
,ort
,land_id
,herst_fg
,ampel_flg
)
AS
   -- 19.12.2023, AP0038599, AP0038599 - alle Mandaten aufnhemen 
   SELECT v01.gp_id, v01.gp_name, v01.mandant_id, v01.gp_strasse, v01.gp_plz, v01.gp_ort, v01.land_id, v01.herst_fg, 1 AS ampel_flg
   FROM dbp_view.v_gp_2 v01
   --WHERE mandant_id = 1
   WHERE herst_fg = 1
;