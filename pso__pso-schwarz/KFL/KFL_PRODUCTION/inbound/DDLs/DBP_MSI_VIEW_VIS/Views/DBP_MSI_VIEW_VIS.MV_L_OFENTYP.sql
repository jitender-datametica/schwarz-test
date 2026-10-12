CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_OFENTYP as
   -- LOOKUP : Backplanung - Ofentyp
   -- 2015KW26 : Backplanung KMO. Anpassung Joins/Bedingungen. Initial

   SELECT
   mandant_id, ofen_typ_id, anz_backblech
   FROM dbp_view.v_l_ofentyp
;