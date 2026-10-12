CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_SPEDITEUR
(mandant_id
,spediteur_id
,spediteur_name

)
AS
   SELECT
  mandant_id, spediteur_id, spediteur_name

   FROM dbp_view.v_l_spediteur
;