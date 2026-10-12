CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_EK_INFOSATZ_WUP_ZU_2
(
mandant_id
, ek_infosatz_id
, wup_id
, nb_id
, prozent_akzeptanz_unterlief

)
AS
   SELECT
  mandant_id, ek_infosatz_id, wup_id, nb_id, prozent_akzeptanz_unterlief

   FROM dbp_view.v_ek_infosatz_wup_zu_2;