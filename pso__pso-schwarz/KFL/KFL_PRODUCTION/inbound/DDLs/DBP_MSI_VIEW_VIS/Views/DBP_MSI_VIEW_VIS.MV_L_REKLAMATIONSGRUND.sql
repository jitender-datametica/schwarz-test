CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_REKLAMATIONSGRUND as
   -- LOOKUP : Lookup Reklamatiuonsgrund
   -- 2012KW07 : Initial (QBM-Bericht)

   SELECT
   v01.mandant_id, v01.reklamationsgrund_id
   FROM dbp_view.v_l_reklamationsgrund v01;