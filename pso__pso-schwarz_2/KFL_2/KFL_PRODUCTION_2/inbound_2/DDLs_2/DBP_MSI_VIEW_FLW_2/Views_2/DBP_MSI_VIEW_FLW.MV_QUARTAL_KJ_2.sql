CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_QUARTAL_KJ_2
(
akt_kj
,akt_kj_komplett
,akt_kjqu
,akt_kjqu_komplett
,kj
,kjqu
)
AS
   SELECT akt_kj, akt_kj_komplett, akt_kjqu, akt_kjqu_komplett, kj, kjqu
   FROM dbp_view.v_tag_2
   GROUP BY 1,2,3,4,5,6;