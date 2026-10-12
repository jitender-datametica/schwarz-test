CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_REKL_GRUND_1

(
rekl_grund_id
,rekl_grund_bez

)
AS
   SELECT
   reklamationsgrund_id, reklamationsgrund_bez
   FROM dbp_view.v_reklamationsgrund_spr_zu_1 v01
   WHERE v01.mandant_id = 1
   AND v01.spr_id = 22;