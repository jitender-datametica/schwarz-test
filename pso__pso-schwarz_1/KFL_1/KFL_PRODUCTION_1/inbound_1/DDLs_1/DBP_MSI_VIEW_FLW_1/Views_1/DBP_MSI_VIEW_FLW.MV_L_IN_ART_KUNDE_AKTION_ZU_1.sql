CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_ART_KUNDE_AKTION_ZU_1
AS
   SELECT
   v01.mandant_id, v03.flw_kunde_id AS in_kunde_id, v02.flw_art_id AS in_art_id, v01.dat, CASE WHEN v01.aktion_fg = 1
   THEN 1002
   ELSE 1001
   END     bewart_id

   FROM dbp_view.v_art_wup_tag_denorm_1 v01
   INNER JOIN dbp_view.v_flw_art_1  v02
   ON
   v02.art_id = v01.art_id AND
   v02.mandant_id = v01.mandant_id
   INNER  JOIN dbp_view.v_flw_kunde_1  v03
   ON
   v01.wup_id = v03.wup_id AND
   v01.mandant_id= v03.mandant_id

   WHERE
   v01.mandant_id =1   AND v03.wup_id > 0;