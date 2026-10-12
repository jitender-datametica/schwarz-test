CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_ANLIEFERUNG_SPEDITEUR_2
(
anlieferung_spediteur_id
,anlieferung_spediteur_name
)
AS
   SELECT
   anlieferung_spediteur_id, anlieferung_spediteur_name
   FROM dbp_view.v_l_anlieferung_spediteur_2
;