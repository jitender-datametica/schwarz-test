CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_QUARTAL_GJ_1
(
akt_gj
,akt_gj_komplett
,akt_gjqu
,akt_gjqu_komplett
,gj
,gjqu
)
AS
   SELECT akt_gj, akt_gj_komplett, akt_gjqu, akt_gjqu_komplett, gj, gjqu
   FROM dbp_view.v_tag_1
   GROUP BY 1,2,3,4,5,6;