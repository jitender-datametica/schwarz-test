CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_MA_HIERARCHIE_TYP_1 as
   -- LOOKUP Hierarchietyp in MA-Hierarchie
   -- Enthaelt alle Hierarchietypen (VAUS, SB)
   -- 201201 Initial

   SELECT
   v01.mandant_id, v01.ma_hierarchie_typ_id
   FROM dbp_view.v_l_ma_hierarchie_typ_1  v01;